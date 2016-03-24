describe CommentCreatedBadge do

  subject { CommentCreatedBadge.new(icon: 'icon', achievment: 2, types: {})}

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    it 'returns user_ids which have at least comments by given count' do

      user_ids = instance_double('Hash')
      returned_user_ids = instance_double('Hash')

      expect(CommentQueries).to receive(:user_ids_with_at_least_comments).with(user_ids: user_ids, count: subject.achievement).
          and_return(returned_user_ids)
      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids).to be returned_user_ids
    end
  end
end