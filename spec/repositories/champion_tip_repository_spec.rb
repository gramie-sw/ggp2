describe ChampionTipRepository do

  subject { ChampionTip }

  describe '::all_with_no_team' do

    it 'should return all with no team set' do

      user_1 = create(:user)
      create(:user)
      user_2 = create(:user)

      create(:champion_tip, team: nil, user: user_1)
      create(:champion_tip, user: user_2)
      create(:champion_tip, team: nil, user: user_2)

      actual_champion_tips = subject.all_with_no_team
      expect(actual_champion_tips.size).to eq 2
    end
  end

  describe '::user_ids_with_no_champion_tip' do

    it 'should return user_ids with no champion tip' do

      user_ids = instance_double('Hash')
      relation = instance_double('ActiveRecord::Relation::ActiveRecord_Relation_Champion_Tip')

      expect(ChampionTip).to receive(:all_with_no_team).and_return(relation)
      expect(relation).to receive(:pluck).with(:user_id).and_return(user_ids)
      actual_user_ids = subject.user_ids_with_no_champion_tip
      expect(actual_user_ids).to be user_ids
    end
  end

  describe '::save_multiple' do

    let(:champion_tips) {
      [
          build(:champion_tip),
          build(:champion_tip)
      ]
    }

    it 'should save multiple champion tips' do

      result = subject.save_multiple champion_tips

      expect(result).to be_truthy
      expect(ChampionTip.count).to eq 2
    end

    it 'should save multiple champion tips transactionally' do

      expect(champion_tips.second).to receive(:save).and_return(false)

      result = subject.save_multiple champion_tips

      expect(result).to be_falsey
      expect(ChampionTip.count).to eq 0
    end
  end
end