describe Tips::SetResults do

  subject { Tips::SetResults }

  let(:match) { create(:match, score_team_1: 1, score_team_2: 2) }

  describe '#run' do

    it 'sets result on tipped tips by given match id and saves them' do
      tip_1 = create(:tip, match: match, score_team_1: 2, score_team_2: 1)
      tip_2 = create(:tip, score_team_1: 2, score_team_2: 1)
      tip_3 = create(:tip, match: match, score_team_1: nil, score_team_2: nil)
      tip_4 = create(:tip, match: match, score_team_1: 1, score_team_2: 2)
      tip_5 = create(:tip, match: match, score_team_1: 2, score_team_2: 3)

      subject.run(match_id: match.id)

      expect(tip_1.reload.result).to eq Tip::RESULTS[:incorrect]
      expect(tip_2.reload.result).to be_nil
      expect(tip_3.reload.result).to eq Tip::RESULTS[:incorrect]
      expect(tip_4.reload.result).to eq Tip::RESULTS[:correct]
      expect(tip_5.reload.result).to eq Tip::RESULTS[:correct_tendency_with_score_difference]
    end
  end
end