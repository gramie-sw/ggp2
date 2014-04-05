describe TipResultService do

  describe '#update_tips_with_result' do

    let(:match) { create(:match, score_team_1: 1, score_team_2: 2)}

    subject { TipResultService.new(match_id: match.id)}

    it 'should set result on tipped tips by given match and saves them' do
      tip_1 = create(:tip, match: match, score_team_1: 2, score_team_2: 1)
      tip_2 = create(:tip, score_team_1: 2, score_team_2: 1)
      tip_3 = create(:tip, match: match, score_team_1: nil, score_team_2: nil)
      tip_4 = create(:tip, match: match,score_team_1: 1, score_team_2: 2)
      tip_5 = create(:tip, match: match, score_team_1: 2, score_team_2: 3)

      subject.update_tips_with_result.should be_true

      tip_1.reload.result.should eq Tip::RESULTS[:incorrect]
      tip_2.reload.result.should be_nil
      tip_3.reload.result.should be_nil
      tip_4.reload.result.should eq Tip::RESULTS[:correct]
      tip_5.reload.result.should eq Tip::RESULTS[:correct_tendency_only]
    end
  end
end