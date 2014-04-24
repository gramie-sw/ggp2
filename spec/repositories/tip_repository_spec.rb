describe TipRepository do

  subject { Tip }

  describe '::all_by_match_id' do

    it 'should return all tips belongs to match' do
      expected_match = create(:match)
      tip_1 = create(:tip, match: expected_match)
      tip_2 = create(:tip, match: expected_match)
      create(:tip)

      actual_tips = subject.all_by_match_id(expected_match.id)
      actual_tips.count.should be 2
      actual_tips.should include tip_1, tip_2
    end
  end


  describe '::order_by_match_id' do

    it 'should order tip by matches position' do
      tip_3 = create(:tip, match: create(:match, position: 3))
      tip_1 = create(:tip, match: create(:match, position: 1))
      tip_2 = create(:tip, match: create(:match, position: 2))

      actual_tips = Tip.order_by_match_position
      actual_tips.first.should eq tip_1
      actual_tips.second.should eq tip_2
      actual_tips.third.should eq tip_3
    end
  end

  describe '::tipped' do

    it 'should return all tipped tips' do
      tip_1 = create(:tip, score_team_1: 1, score_team_2: 0)
      create(:tip, score_team_1: nil, score_team_2: nil)
      tip_3 = create(:tip, score_team_1: 2, score_team_2: 2)

      tips = subject.tipped
      tips.count.should eq 2
      tips.should include tip_1, tip_3
    end
  end

  describe '::update_multiple_tips' do

    let(:tips) do
      [
        build(:tip),
        build(:tip),
        build(:tip)
      ]
    end

    it 'should update all given tips' do

      expect(subject.update_multiple_tips(tips)).to be_true
      expect(tips[0].reload.new_record?).to be_false
      expect(tips[1].reload.new_record?).to be_false
      expect(tips[2].reload.new_record?).to be_false
    end

    it 'should update all given tips transactional' do

      tips[1].score_team_1 = -1

      expect(subject.update_multiple_tips(tips)).to be_false
      expect(Tip.all.size).to eq 0
    end
  end
end