describe PinBoardsShowPresenter do

  let(:current_user_id) { 10 }
  let(:page) { 2 }
  let(:comments_repo) { double('CommentsRepo') }
  let(:is_admin) { false }

  subject do
    PinBoardsShowPresenter.new(
        comments_repo: comments_repo,
        page: page,
        current_user_id: current_user_id,
        is_admin: is_admin
    )
  end


  describe '#comment_presenters' do

    let(:comments) do
      [
          build(:comment, user_id: current_user_id),
          build(:comment, user_id: current_user_id+1)
      ]
    end

    before :each do
      allow(subject).to receive(:comments).and_return(comments)
    end

    it 'should return comments as CommentPresenters' do
      actual_comment_presenters = subject.comment_presenters
      expect(actual_comment_presenters.count).to eq 2
      expect(actual_comment_presenters.first.__getobj__).to eq comments.first
      expect(actual_comment_presenters.second.__getobj__).to eq comments.second
    end

    it 'should set correct is_for_current_user argument when instantiate CommentPresenters' do
      expect(CommentsPresenter).to receive(:new).with(comment: comments.first, is_for_current_user: true, is_admin: false)
      expect(CommentsPresenter).to receive(:new).with(comment: comments.second, is_for_current_user: false, is_admin: false)
      subject.comment_presenters
    end

    it 'should cache values' do
      expect(subject.comment_presenters).to be subject.comment_presenters
    end
  end

  describe '#comments' do

    it 'should return comments_repo#comments_for_pin_board' do
      expect(comments_repo).to receive(:comments_for_pin_board).with(page).and_return(:comments_relation)
      expect(subject.comments).to eq :comments_relation
    end

    it 'should cache value' do
      expect(comments_repo).to receive(:comments_for_pin_board).once.and_return(:comments_relation)
      subject.comments
      subject.comments
    end
  end
end