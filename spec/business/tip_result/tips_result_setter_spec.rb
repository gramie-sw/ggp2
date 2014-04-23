describe TipsResultSetter do

  let(:tips) do
    [
      build(:tip, score_team_1: 3, score_team_2: 2),
      build(:tip, score_team_1: 4, score_team_2: 2),
      build(:tip, score_team_1: 1, score_team_2: 2)
    ]
  end

  let(:match) { build(:match, score_team_1: 3, score_team_2: 2)}

  describe '::set_results' do

    it'should results on given tips' do
      subject.set_results(match, tips)

      expect(tips[0].result).to eq Tip::RESULTS[:correct]
      expect(tips[1].result).to eq Tip::RESULTS[:correct_tendency_only]
      expect(tips[2].result).to eq Tip::RESULTS[:incorrect]
    end
  end
end