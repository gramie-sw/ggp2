describe ShowChampionTip do

  describe 'run_with_presentable' do

    let(:presentable) { double('ShowChampionTipPresentable') }

    it 'should set ChampionTip to presentable' do
      expected_champion_tip = create(:champion_tip)
      expect(presentable).to receive(:champion_tip=).with(expected_champion_tip)

      subject.run_with_presentable(presentable, expected_champion_tip.user_id.to_s)
    end
  end
end