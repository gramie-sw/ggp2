describe CommentCreatedBadge do

  subject { CommentCreatedBadge.new(count: 3, position: 1, icon: 'icon', icon_color: 'icon_color', identifier: 'identifier') }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 3
      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
      expect(subject.identifier).to eq 'identifier'
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids which have at least comments by given count' do

      user_ids = instance_double('Hash')

      expect(Comment).to receive(:user_ids_with_at_least_comments).with(subject.count).and_return(user_ids)
      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids).to be user_ids
    end
  end
end