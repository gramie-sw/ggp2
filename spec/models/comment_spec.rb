describe Comment do

  it 'should have valid factory' do
    build(:comment).should be_valid
  end

  describe 'validations' do

    describe 'user' do
      it { should validate_presence_of :user }
    end

    describe 'content' do
      it { should validate_presence_of :content }
      it { should ensure_length_of(:content).is_at_most(500) }
    end
  end

  describe 'associations' do

    it { should belong_to :user }
  end

  describe 'scopes' do

    describe '#order_by_created_at_desc' do

      it 'should return comments order by created at asc' do
        comment_3 = create(:comment, created_at: 1.days.ago)
        comment_1 = create(:comment, created_at: 1.day.from_now)
        comment_2 = create(:comment, created_at: Date.current)

        actual_comments = Comment.order_by_created_at_desc
        actual_comments.first.should eq comment_1
        actual_comments.second.should eq comment_2
        actual_comments.third.should eq comment_3

      end
    end

    describe '#order_by_created_at_desc' do

      it 'should return comments relation for pin_boards' do
        relation = double('CommentRelation')
        relation.as_null_object

        Comment.should_receive(:order_by_created_at_desc).and_return(relation)
        relation.should_receive(:includes).with(:user).and_return(relation)
        relation.should_receive(:page).with(2).and_return(relation)
        relation.should_receive(:per).with(10).and_return(relation)

        Comment.comments_for_pin_board(2).should eq relation
      end
    end
  end
end
