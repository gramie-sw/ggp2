describe ShowWinnerRanking do

  describe '#run' do

    it 'should fill presenter' do

      winner_ranking_items = [
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 1),
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 3)
      ]

      presenter = double('Presenter')
      presenter.should_receive(:first_places=).with do |actual_ranking_items|
        actual_ranking_items.count.should eq 1
        actual_ranking_items.should include winner_ranking_items.second
      end

      presenter.should_receive(:second_places=).with do |actual_ranking_items|
        actual_ranking_items.count.should eq 2
        actual_ranking_items.should include winner_ranking_items.first, winner_ranking_items.third
      end
      presenter.should_receive(:third_places=).with do |actual_ranking_items|
        actual_ranking_items.count.should eq 1
        actual_ranking_items.should include winner_ranking_items.fourth
      end

      subject.run(presenter)
    end
  end

end