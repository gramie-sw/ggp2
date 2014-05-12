describe TipChampionMissedBadge do

  subject { TipChampionMissedBadge.new(position: 1, icon: 'icon', icon_color: 'icon_color')}

  describe '#initialize' do

    it 'should provide mass assignment' do

      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
    end
  end

  describe '#eligible_user_ids' do

    context 'when tournament is not started' do

      it 'should return empty array' do

        expect_any_instance_of(Tournament).to receive(:started?).and_return false
        expect(ChampionTip).not_to receive(:user_ids_with_no_champion_tip)

        user_ids = subject.eligible_user_ids
        expect(user_ids).to eq []
      end
    end

    context 'when tournament is started' do

      let(:user_ids) { Hash.new}

      it 'should return all user_ids with no champion tip' do

        expect_any_instance_of(Tournament).to receive(:started?).and_return true
        expect(ChampionTip).to receive(:user_ids_with_no_champion_tip).and_return(user_ids)

        actual_user_ids = subject.eligible_user_ids
        expect(actual_user_ids).to be user_ids
      end
    end
  end

  describe '#identifier' do

    it 'should return symbolized underscored class name ' do
      expect(subject.identifier).to eq :tip_champion_missed_badge
    end
  end
end