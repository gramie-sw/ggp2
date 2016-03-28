describe TipQueries do

  describe '::all_by_match_id' do

    match_id = 34

    let(:tips) do
      [Tip.create_unvalidated(match_id: match_id, score_team_1: 0, score_team_2: 1),
       Tip.create_unvalidated(match_id: match_id, score_team_1: nil, score_team_2: 1),
       Tip.create_unvalidated(match_id: match_id+1, score_team_1: 2, score_team_2: 1)]
    end

    it 'returns all Tips of match_id' do
      expect(subject.all_by_match_id(match_id)).to eq [tips.first, tips.second]
    end
  end

  describe '::all_eager_by_user_id_and_aggregate_id_ordered' do

    let(:users) { [create(:player), create(:player)] }

    let(:tips) do
      [
          create(:tip, match: matches.first, user: users.first),
          create(:tip, match: matches.first, user: users.second),
          create(:tip, match: matches.second, user: users.first),
          create(:tip, match: matches.second, user: users.second),
          create(:tip, match: matches.third, user: users.first),
          create(:tip, match: matches.third, user: users.second)
      ]
    end

    let(:aggregates) { [create(:phase), create(:phase)] }

    let(:matches) do
      [
          create(:match, aggregate: aggregates.first, position: 2),
          create(:match, aggregate: aggregates.first, position: 1),
          create(:match, aggregate: aggregates.second, position: 3),
      ]
    end

    describe 'if aggregate has no groups' do


      it 'returns all tips for given user_id and aggregate_id by given order' do
        actual_tips =subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, aggregates.first.id, order: 'matches.position')
        expect(actual_tips).to eq [tips.third, tips.first]
      end
    end

    describe 'if aggregate has groups' do

      let(:phase) { create(:phase) }
      let!(:groups) { [create(:group, parent: phase), create(:group, parent: phase), create(:group)] }

      let(:matches) do
        [
            create(:match, aggregate: groups.first, position: 2),
            create(:match, aggregate: groups.second, position: 1),
            create(:match, aggregate: groups.third, position: 3),
        ]
      end

      it 'returns all tips for given user_id and aggregate_id recursive by given order' do
        actual_tips = subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, phase.id, order: 'matches.position')
        expect(actual_tips).to eq [tips.third, tips.first]
      end
    end

    describe 'if no order is given' do

      it 'returns tips ordered by match ids' do
        actual_tips = subject.all_eager_by_user_id_and_aggregate_id_ordered_by_position(
            users.first.id, aggregates.first.id)
        expect(actual_tips).to eq [tips.first, tips.third]
      end
    end
  end

  describe '::clear_all_results_by_match_id' do

    match_id = 6

    let!(:tips) do
      [Tip.create_unvalidated(result: 0, match_id: match_id),
       Tip.create_unvalidated(result: 2, match_id: match_id),
       Tip.create_unvalidated(result: 1, match_id: match_id+1)]
    end

    it 'destroys all Tips for given match_id' do
      subject.clear_all_results_by_match_id(match_id)
      tips.each(&:reload)
      expect(tips.first.result).to be_nil
      expect(tips.second.result).to be_nil
      expect(tips.third.result).to be 1
    end
  end

  describe '::group_by_user_with_at_least_tips' do

    let(:players) { (1..2).map { create(:player) } }

    let!(:tips) do
      create(:tip, user: players.first)
      create(:tip, user: players.second)
      create(:tip, user: players.first)
    end

    it 'returns all grouped tips where user has at least tips' do
      expect(TipQueries.group_by_user_with_at_least_tips(2).pluck(:user_id)).to eq [players.first.id]
    end
  end

  describe '::finished_match_position_ordered_results' do

    let(:players) { (1..2).map { create(:player) } }

    it 'returns all results from finished matches in order of match position by given user_id' do
      match_1 = create(:match, score_team_1: 1, score_team_2: 2, position: 1)
      match_2 = create(:match, score_team_1: 1, score_team_2: 2, position: 2)
      match_3 = create(:match, score_team_1: nil, score_team_2: nil, position: 3)

      create(:tip, user: players.first, match: match_2, result: Tip::RESULTS[:correct])
      create(:tip, user: players.first, match: match_3, result: Tip::RESULTS[:incorrect])
      create(:tip, user: players.first, match: match_1, result: Tip::RESULTS[:incorrect])
      create(:tip, user: players.second, match: match_1)

      expect(TipQueries.finished_match_position_ordered_results(players.first)).to eq [Tip::RESULTS[:incorrect],
                                                                                       Tip::RESULTS[:correct]]
    end
  end

  describe '::match_position_ordered_results' do

    let(:players) { (1..2).map { create(:player) } }
    let(:matches) { (1..2).map { create(:match) } }

    it 'returns all results ordered by match position by given user_id' do
      create(:tip, match: matches.second, user: players.first, result: Tip::RESULTS[:correct])
      create(:tip, match: matches.second, user: players.second, result: Tip::RESULTS[:incorrect])
      create(:tip, match: matches.first, user: players.first, result: Tip::RESULTS[:incorrect])

      expect(TipQueries.match_position_ordered_results(players.first)).to eq [Tip::RESULTS[:incorrect], Tip::RESULTS[:correct]]
    end
  end

  describe '::missed_tips' do

    it 'returns all missed tips' do
      finished_match = create(:match, score_team_1: 2, score_team_2: 2)
      open_match = create(:match, score_team_1: nil, score_team_2: nil)

      create(:tip, match: finished_match, score_team_1: 3, score_team_2: 2)
      tip = create(:tip, match: finished_match, score_team_1: nil, score_team_2: nil)
      create(:tip, match: open_match, score_team_1: nil, score_team_2: nil)
      create(:tip, match: open_match, score_team_1: 3, score_team_2: 2)

      expect(subject.missed_tips).to eq [tip]
    end
  end

  describe '::order_by_match_position' do

    let(:matches) { (1..3).map {create(:match)}}

    it 'returns tips ordered by match position' do
      tip_1 = create(:tip, match: matches.second)
      tip_2 = create(:tip, match: matches.third)
      tip_3 = create(:tip, match: matches.first)

      expect(TipQueries.order_by_match_position).to eq [tip_3, tip_1, tip_2]
    end
  end

  describe '::order_by_match_position_by_given_ids' do

    let(:matches) { (1..3).map {create(:match)}}

    it 'returns tips ordered by match position restricted by given tip ids' do
      tip_1 = create(:tip, match: matches.second)
      create(:tip, match: matches.third)
      tip_3 = create(:tip, match: matches.first)

      actual_tips = TipQueries.order_by_match_position_by_given_ids([tip_1, tip_3])
      expect(actual_tips).to eq [tip_3, tip_1]
    end
  end

  describe '::tips_with_finished_matches' do

    it 'returns tips with finished matches' do
      finished_match = create(:match, score_team_1: 2, score_team_2: 2)
      open_match = create(:match, score_team_1: nil, score_team_2: nil)

      tip_1 = create(:tip, match: finished_match, score_team_1: nil, score_team_2: nil)
      tip_2 = create(:tip, match: finished_match, score_team_1: nil, score_team_2: nil)
      create(:tip, match: open_match, score_team_1: 3, score_team_2: 2)

      actual_tips = TipQueries.tips_with_finished_match
      expect(actual_tips.size).to be 2
      expect(actual_tips).to include tip_1, tip_2
    end
  end

  describe '::user_ids_with_at_least_result_tips' do

    let(:players) { (1..4).map { create(:player) } }

    it 'returns all user ids whicht have at least count result tips' do
      (1..2).each { create(:tip, result: Tip::RESULTS[:correct], user: players.first) }
      (1..3).each { create(:tip, result: Tip::RESULTS[:correct], user: players.third) }
      (1..2).each { create(:tip, result: Tip::RESULTS[:correct], user: players.fourth) }
      create(:tip, result: Tip::RESULTS[:correct], user: players.second)
      create(:tip, result: Tip::RESULTS[:incorrect], user: players.second)

      considered_players = [players.first, players.second, players.third]
      actual_user_ids = TipQueries.user_ids_with_at_least_result_tips(result: Tip::RESULTS[:correct],
                                                                      user_ids: considered_players, count: 2)
      expect(actual_user_ids).to eq [players.first.id, players.third.id]
    end
  end

  describe '::user_ids_with_at_least_missed_tips' do

    let(:players) { (1..4).map { create(:player) } }

    it 'returns all user ids which have at least count missed tips restricted by given user_ids' do
      create(:tip, user: players.first, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.first, score_team_1: nil, score_team_2: nil)
      create(:tip, user: players.first, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.second, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.second, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.third, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.third, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.third, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.fourth, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))
      create(:tip, user: players.fourth, score_team_1: nil, score_team_2: nil, match: create(:match, score_team_1: 1, score_team_2: 2))

      considered_players = [players.first, players.second, players.third]
      actual_user_ids = TipQueries.user_ids_with_at_least_missed_tips(user_ids: considered_players, count: 2)
      expect(actual_user_ids).to eq [players.second.id, players.third.id]
    end
  end
end
