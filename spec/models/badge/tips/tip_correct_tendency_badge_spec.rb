describe TipCorrectTendencyBadge do

  subject { TipCorrectTendencyBadge.new(result: 'correct', icon: 'my_icon', color: 'gold', achievement: 2) }

  it { is_expected.to be_a Badge }

  describe '#eligible_user_ids' do

    it 'returns user ids which have at least count correct tendency tips restricted by given user ids' do

      eligible_user_ids = 'eligible_user_ids'
      user_ids = [1, 2, 3, 4, 5]
      results = [
          Tip::RESULTS[:correct_tendency_only],
          Tip::RESULTS[:correct_tendency_with_score_difference],
          Tip::RESULTS[:correct_tendency_with_one_score]
      ]


      expect(TipQueries).to receive(:user_ids_with_at_least_result_tips).with(result: results, user_ids: user_ids,
                                                                              count: subject.achievement).and_return(eligible_user_ids)

      actual_user_ids = subject.eligible_user_ids user_ids
      expect(actual_user_ids).to eq eligible_user_ids
    end
  end
end