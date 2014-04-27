describe ConsecutiveCreatedCommentBadge do

  subject { ConsecutiveCreatedCommentBadge.new(count: 3) }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 3
    end
  end

  describe '#eligible_user_ids' do

  end

  describe '#identifier' do
    it'should return symbolized underscored class name with count value' do
      expect(subject.identifier).to eq :consecutive_created_comment_badge_3
    end
  end
end