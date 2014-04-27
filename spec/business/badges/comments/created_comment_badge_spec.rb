describe CreatedCommentBadge do

  subject { CreatedCommentBadge.new(count: 3) }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 3
    end
  end

  describe '#eligible_user_ids' do

    let(:comment_relation) { double('comment_relation')}

    it 'should return user_ids which have at least comments by given count' do

      expect(Comment).to receive(:user_ids_with_at_least_comments).with(subject.count).and_return(comment_relation)
      expect(comment_relation).to receive(:pluck).with(:user_id)
      subject.eligible_user_ids
    end
  end

  describe '#identifier' do
    it 'should return symbolized underscored class name with count value' do
      expect(subject.identifier).to eq :created_comment_badge_3
    end
  end
end