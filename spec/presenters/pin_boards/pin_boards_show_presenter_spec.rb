describe PinBoardsShowPresenter do

  let(:current_user_id) { 10 }
  let(:page) { 2 }
  let(:comments_repo) { double('CommentsRepo') }

  subject do
    PinBoardsShowPresenter.new(
        comments_repo: comments_repo,
        page: page,
        current_user_id: current_user_id)
  end

  describe '#comment_presenters' do

    let(:comments) do
      [
          build(:comment, user_id: current_user_id),
          build(:comment, user_id: current_user_id+1)
      ]
    end

    before :each do
      subject.stub(:comments).and_return(comments)
    end

    it 'should return comments as CommentPresenters' do
      actual_comment_presenters = subject.comment_presenters
      actual_comment_presenters.count.should eq 2
      actual_comment_presenters.first.__getobj__.should eq comments.first
      actual_comment_presenters.second.__getobj__.should eq comments.second
    end

    it 'should set correct is_for_current_user argument when instantiate CommentPresenters' do
      CommentsPresenter.should_receive(:new).with(comment: comments.first, is_for_current_user: true)
      CommentsPresenter.should_receive(:new).with(comment: comments.second, is_for_current_user: false)
      subject.comment_presenters
    end

    it 'should cache values' do
      subject.comment_presenters.should be subject.comment_presenters
    end
  end

  describe '#comments' do

    it 'should return comments_repo#comments_for_pin_board' do
      comments_repo.should_receive(:comments_for_pin_board).with(page).and_return(:comments_relation)
      subject.comments.should eq :comments_relation
    end

    it 'should cache value' do
      comments_repo.should_receive(:comments_for_pin_board).once.and_return(:comments_relation)
      subject.comments
      subject.comments
    end
  end
end