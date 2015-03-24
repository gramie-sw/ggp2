describe Comment, :type => :model do

  it 'should have valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'should include module CommentRepository' do
    expect(Comment.included_modules).to include CommentRepository
  end

  describe 'validations' do

    describe 'user' do
      it { is_expected.to validate_presence_of :user }
    end

    describe 'content' do
      it { is_expected.to validate_presence_of :content }
      it { is_expected.to validate_length_of(:content).is_at_most(500) }
    end
  end

  describe 'associations' do

    it { is_expected.to belong_to :user }
  end

  describe 'scopes' do

    describe '#order_by_created_at_desc' do

      it 'should return comments order by created at asc' do
        comment_3 = create(:comment, created_at: 1.days.ago)
        comment_1 = create(:comment, created_at: 1.day.from_now)
        comment_2 = create(:comment, created_at: Date.current)

        actual_comments = Comment.order_by_created_at_desc
        expect(actual_comments.first).to eq comment_1
        expect(actual_comments.second).to eq comment_2
        expect(actual_comments.third).to eq comment_3

      end
    end

    describe '#order_by_created_at_desc' do

      it 'should return comments relation for pin_boards' do
        relation = double('CommentRelation')
        relation.as_null_object

        expect(Comment).to receive(:order_by_created_at_desc).and_return(relation)
        expect(relation).to receive(:includes).with(:user).and_return(relation)
        expect(relation).to receive(:page).with(2).and_return(relation)
        expect(relation).to receive(:per).with(10).and_return(relation)

        expect(Comment.comments_for_pin_board(2)).to eq relation
      end
    end
  end
end
