describe CommentCreatedBadge do

  subject { CommentCreatedBadge.new(count: 3, position: 1) }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 3
      expect(subject.position).to eq 1
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids which have at least comments by given count' do

      expect(Comment).to receive(:user_ids_with_at_least_comments).with(subject.count)
      subject.eligible_user_ids
    end
  end

  describe '#identifier' do
    it 'should return symbolized underscored class name with count value' do
      expect(subject.identifier).to eq :comment_created_badge_3
    end
  end
end