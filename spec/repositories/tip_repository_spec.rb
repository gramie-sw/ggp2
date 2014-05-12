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

  describe '::all_by_result' do

    it 'should return all tips by given result' do

      tip_1 = create(:tip, result: Tip::RESULTS[:correct])
      create(:tip, result: Tip::RESULTS[:incorrect])
      create(:tip, result: Tip::RESULTS[:correct_tendency_only])
      tip_2 = create(:tip, result: Tip::RESULTS[:correct])

      actual_tips = subject.all_by_result(Tip::RESULTS[:correct])
      expect(actual_tips.size).to eq 2
      expect(actual_tips[0]).to eq tip_1
      expect(actual_tips[1]).to eq tip_2
    end
  end

  describe '::all_by_user_id' do

    it 'should return all tips by given user id' do

      user_1 = create(:user)
      user_2 = create(:user)

      tip_1 = create(:tip, user_id: user_1.id)
      create(:tip, user_id: user_2.id)
      tip_2 = create(:tip, user_id: user_1.id)

      actual_tips = subject.all_by_user_id(user_1.id)
      expect(actual_tips.size).to eq 2
      expect(actual_tips).to include(tip_1, tip_2)
    end
  end

  describe '::finished_match' do

    it 'should return tips with finished match' do

      match_1 = create(:match, score_team_1: 1, score_team_2: 2)
      match_2 = create(:match, score_team_1: nil, score_team_2: nil)
      match_3 = create(:match, score_team_1: 1, score_team_2: 2)

      tip_1 = create(:tip, match: match_1)
      create(:tip, match: match_2)
      tip_2 = create(:tip, match: match_3)

      tips = subject.finished_match
      expect(tips.size).to eq 2
      expect(tips).to include tip_1, tip_2
    end
  end


  describe '::group_by_user_with_at_least_tips' do

    it 'should return all grouped tips where user has at least tips' do

      user_1 = create(:user)
      user_2 = create(:user)

      create(:tip, user: user_1)
      create(:tip, user: user_2)
      create(:tip, user: user_1)

      actual_user_ids = subject.group_by_user_with_at_least_tips(2).pluck(:user_id)
      expect(actual_user_ids.size).to eq 1
      expect(actual_user_ids[0]).to eq user_1.id
    end
  end

  describe '::missed_tips' do

    it 'should return all missed_tips' do

      relation = instance_double('ActiveRecord::Relation::ActiveRecord_Relation_Tip')
      expect(Tip).to receive(:not_tipped).and_return(relation)
      expect(relation).to receive(:finished_match)

      subject.missed_tips
    end
  end

  describe '::not_tipped' do

    it 'should return all not tipped tips' do

      tip_1 = create(:tip, score_team_1: nil, score_team_2: nil)
      create(:tip, score_team_1: 3, score_team_2: 2)
      tip_3 = create(:tip, score_team_1: nil, score_team_2: nil)

      tips = subject.not_tipped
      tips.count.should eq 2
      tips.should include tip_1, tip_3
    end
  end


  describe '::order_by_match_id' do

    it 'should order tip by match position' do

      tip_3 = create(:tip, match: create(:match, position: 3))
      tip_1 = create(:tip, match: create(:match, position: 1))
      tip_2 = create(:tip, match: create(:match, position: 2))

      actual_tips = Tip.order_by_match_position
      actual_tips.first.should eq tip_1
      actual_tips.second.should eq tip_2
      actual_tips.third.should eq tip_3
    end
  end

  describe '::ordered_results_having_finished_match_by_user_id' do

    it 'should return all results by user_id ordered by match position and are finished' do

      user_1 = create(:player)
      user_2 = create(:player)

      create(:tip, user: user_1, match: create(:match, score_team_1: 1, score_team_2: 2), result: Tip::RESULTS[:correct])
      create(:tip, user: user_1, result: Tip::RESULTS[:incorrect])
      create(:tip, user: user_1, match: create(:match, score_team_1: 1, score_team_2: 2), score_team_1: nil,
             score_team_2: nil, result: nil)
      create(:tip, user: user_2, match: create(:match, score_team_1: 1, score_team_2: 2),
             result: Tip::RESULTS[:correct_tendency_only])

      actual_results = subject.ordered_results_having_finished_match_by_user_id(user_1)
      expect(actual_results.size).to eq 2
      expect(actual_results.first).to eq Tip::RESULTS[:correct]
      expect(actual_results.second).to be nil
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

  describe '::results_by_user_id' do

    it 'should return all results by given user_id' do

      user_1 = create(:user)
      user_2 = create(:user)

      match_1 = create(:match, position: 1)
      match_2 = create(:match, position: 2)

      create(:tip, match_id: match_2.id, user_id: user_1.id, result: Tip::RESULTS[:correct])
      create(:tip, match_id: match_2.id, user_id: user_2.id, result: Tip::RESULTS[:incorrect])
      create(:tip, match_id: match_1.id, user_id: user_1.id, result: Tip::RESULTS[:incorrect])

      actual_results = subject.ordered_results_by_user_id(user_1)
      expect(actual_results.size).to eq 2
      expect(actual_results[0]).to eq Tip::RESULTS[:incorrect]
      expect(actual_results[1]).to eq Tip::RESULTS[:correct]
    end
  end

  describe '::user_ids_with_at_least_result_tips' do

    it 'should return alld user ids which have at least count result tips' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:tip, result: Tip::RESULTS[:correct], user: user_1)
      create(:tip, result: Tip::RESULTS[:correct], user: user_2)
      create(:tip, result: Tip::RESULTS[:incorrect], user: user_2)
      create(:tip, result: Tip::RESULTS[:correct], user: user_3)
      create(:tip, result: Tip::RESULTS[:correct], user: user_3)
      create(:tip, result: Tip::RESULTS[:correct], user: user_3)
      create(:tip, result: Tip::RESULTS[:correct], user: user_1)

      actual_user_ids = subject.user_ids_with_at_least_result_tips(result: Tip::RESULTS[:correct], count: 2)
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids[0]).to eq user_1.id
      expect(actual_user_ids[1]).to eq user_3.id
    end
  end

  describe '::user_ids_with_at_least_missed_tips' do

    it 'should return all user ids which have at least count missed tips' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:tip, user: user_1, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_2, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_3, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_1, score_team_1: nil, score_team_2: nil, match: create(:match))
      create(:tip, user: user_2, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_3, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_1, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_2, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: user_3, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))

      actual_user_ids = subject.user_ids_with_at_least_missed_tips(count: 2)
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(user_2.id, user_3.id)
    end
  end
end