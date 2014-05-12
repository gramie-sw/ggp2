describe TipMissedBadge do

  subject { TipMissedBadge.new(position: 1, icon: 'icon', icon_color: 'icon_color', count: 2) }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do

      expect(subject.position).to eq 1
      expect(subject.icon).to eq 'icon'
      expect(subject.icon_color).to eq 'icon_color'
      expect(subject.count).to eq 2
    end
  end

  describe '#eligible_user_ids' do

    let(:user_ids) { Hash.new}

    it 'should return all user ids which have at least count missed tips' do

      expect(Tip).to receive(:user_ids_with_at_least_missed_tips).with(count: 2).and_return(user_ids)
      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids).to be user_ids
    end
  end

  describe '#identifier' do

    it 'should return symbolized underscored class name with count value appended' do
      expect(subject.identifier).to eq :tip_missed_badge_2
    end
  end
end