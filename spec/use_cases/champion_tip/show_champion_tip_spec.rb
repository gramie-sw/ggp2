describe ShowChampionTip do


  describe 'run_with_presentable' do

    let(:expected_champion_tip) { create(:champion_tip) }
    let(:presentable) { double('ShowChampionTipPresentable') }
    subject { ShowChampionTip.new(expected_champion_tip.user_id.to_s) }

    it 'should set ChampionTip to presentable' do
      expect(presentable).to receive(:champion_tip=).with(expected_champion_tip)
      subject.run_with_presentable(presentable)
    end
  end
end