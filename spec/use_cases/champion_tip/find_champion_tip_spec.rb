describe FindChampionTip do

  describe 'run' do

    let(:expected_champion_tip) { create(:champion_tip) }
    subject { FindChampionTip.new(expected_champion_tip.user_id.to_s) }

    it 'should return ChamptionTip' do
      actual_chamption_tip = subject.run
      expect(actual_chamption_tip).to eq expected_champion_tip
    end
  end
end