describe MatchRepository do

  subject { Match }

  describe '::all_following_matches' do

    it 'should return all matches which have a higher position than given one' do

      match_3 = create(:match, position: 3)
      match_4 = create(:match, position: 4)
      match_2 = create(:match, position: 2)
      create(:match, position: 1)

      actual_matches = Match.all_following_matches_by_position(match_2.position)
      expect(actual_matches.size).to eq 2
      expect(actual_matches).to include match_3, match_4
    end
  end

  describe '::all_previous_matches' do

    it 'should return all matches which have a smaller position than given one' do

      match_3 = create(:match, position: 3)
      create(:match, position: 4)
      match_2 = create(:match, position: 2)
      match_1 =create(:match, position: 1)

      actual_matches = Match.all_previous_matches_by_position(match_3.position)
      expect(actual_matches.size).to eq 2
      expect(actual_matches).to include match_1, match_2
    end
  end

  describe '::count_all_with_results' do

    it 'should return count of all matches' do

      create(:match, score_team_1: nil, score_team_2: nil)
      create(:match, score_team_1: 0, score_team_2: 2)
      create(:match, score_team_1: 1, score_team_2: 1)

      expect(subject.count_all_with_results).to eq 2
    end
  end

  describe '::future_matches' do

    it 'should return only future matches' do

      match_1 = create(:match, date: 2.minutes.from_now)
      match_2 = create(:match, date: 3.minutes.from_now)
      create(:match, date: 1.minutes.ago)

      actual_matches = Match.future_matches
      expect(actual_matches.count).to eq 2
      expect(actual_matches).to include match_1, match_2
    end
  end

  describe '::order_by_position_asc' do

    it 'should order by position' do

      match_3 = create(:match, position: 3)
      match_1 = create(:match, position: 1)
      match_2 = create(:match, position: 2)

      actual_matches = Match.order_by_position_asc
      expect(actual_matches.first).to eq match_1
      expect(actual_matches.second).to eq match_2
      expect(actual_matches.third).to eq match_3
    end
  end

  describe '::order_by_date_asc' do

    it 'should order by date asc' do

      match_3 = create(:match, date: 4.days.from_now)
      match_1 = create(:match, date: 2.days.from_now)
      match_2 = create(:match, date: 3.days.from_now)

      actual_matches = Match.order_by_date_asc
      expect(actual_matches.first).to eq match_1
      expect(actual_matches.second).to eq match_2
      expect(actual_matches.third).to eq match_3
    end
  end

  describe '::all_with_result' do

    it 'should return only matches with result' do
      match_1 = create(:match, score_team_1: 1, score_team_2: 2)
      match_2 = create(:match, score_team_1: 3, score_team_2: 1)
      create(:match, score_team_1: nil, score_team_2: nil)

      actual_matches = Match.all_with_result
      expect(actual_matches.count).to eq 2
      expect(actual_matches).to include match_1, match_2
    end
  end

  describe '::first_match' do

    it 'should return first match' do

      create(:match, position: 3)
      match_1 = create(:match, position: 1)
      create(:match, position: 2)

      expect(subject.first_match).to eq match_1
    end
  end

  describe '::last_match' do

    it 'should return last match' do

      match_3 = create(:match, position: 3)
      create(:match, position: 1)
      create(:match, position: 2)

      expect(subject.last_match).to eq match_3
    end
  end

  describe '::next_match' do

    it 'should return next match' do

      create(:match, date: 4.days.from_now)
      create(:match, date: 1.days.ago)
      expected_match = create(:match, date: 3.days.from_now)

      expect(Match.next_match).to eq expected_match
    end
  end

  describe '::all_matches_of_aggregate_for_listing' do

    context 'when aggregate is a phase' do

      it 'should return matches of belonging groups' do
        phase = create(:phase)
        group_1 = create(:group, parent: phase)
        group_2 = create(:group, parent: phase)
        match_1 = create(:match, aggregate: group_1)
        match_2 = create(:match, aggregate: group_1)
        match_3 = create(:match, aggregate: group_2)
        create(:match)

        actual_matches = subject.all_matches_of_aggregate_for_listing(phase.id)
        expect(actual_matches.count).to eq 3
        expect(actual_matches).to include(match_1, match_2, match_3)
      end
    end

    context 'when aggregate is a group' do

      it 'should return all matches of group' do
        group = create(:group)
        match_1 = create(:match, aggregate: group)
        match_2 = create(:match, aggregate: group)
        create(:match)

        actual_matches = subject.all_matches_of_aggregate_for_listing(group.id)
        expect(actual_matches.count).to eq 2
        expect(actual_matches).to include(match_1, match_2)
      end
    end

    it 'should order matches by position and include teams' do
      relation = double('MatchRelation')
      relation.as_null_object

      expect(subject).to receive(:recursive_match_relation_by_aggregate_id).and_return(relation)
      expect(relation).to receive(:order_by_position_asc).and_return(relation)
      expect(relation).to receive(:includes).with(:team_1, :team_2).and_return(relation)
      subject.all_matches_of_aggregate_for_listing(nil)
    end
  end
end