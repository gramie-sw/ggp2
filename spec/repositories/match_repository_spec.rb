describe MatchRepository do

  subject { Match }

  describe '::order_by_position' do

    it 'should order by position' do

      match_3 = create(:match, position: 3)
      match_1 = create(:match, position: 1)
      match_2 = create(:match, position: 2)

      actual_matches = Match.order_by_position
      actual_matches[0].position.should eq match_1.position
      actual_matches[1].position.should eq match_2.position
      actual_matches[2].position.should eq match_3.position
    end
  end

  describe '::all_following_matches' do
    it 'should return all matches which have a higher position than given one' do
      match_3 = create(:match, position: 3)
      match_4 = create(:match, position: 4)
      match_2 = create(:match, position: 2)
      create(:match, position: 1)

      actual_matches = Match.all_following_matches_by_position(match_2.position)
      actual_matches.size.should eq 2
      actual_matches.should include match_3, match_4
    end
  end

  describe '::all_previous_matches' do
    it 'should return all matches which have a smaller position than given one' do
      match_3 = create(:match, position: 3)
      create(:match, position: 4)
      match_2 = create(:match, position: 2)
      match_1 =create(:match, position: 1)

      actual_matches = Match.all_previous_matches_by_position(match_3.position)
      actual_matches.size.should eq 2
      actual_matches.should include match_1, match_2
    end
  end

  describe '::future_matches' do

    it 'should return only future matches' do
      match_1 = create(:match, date: 2.minutes.from_now)
      match_2 = create(:match, date: 3.minutes.from_now)
      create(:match, date: 1.minutes.ago)

      actual_matches = Match.future_matches
      actual_matches.count.should eq 2
      actual_matches.should include match_1, match_2
    end
  end

  describe '::only_with_result' do

    it 'should return only matches with result' do
      match_1 = create(:match, score_team_1: 1, score_team_2: 2)
      match_2 = create(:match, score_team_1: 3, score_team_2: 1)
      create(:match, score_team_1: nil, score_team_2: nil)

      actual_matches = Match.only_with_result
      actual_matches.count.should eq 2
      actual_matches.should include match_1, match_2
    end
  end

  describe '#first_match' do

    it 'should return first match' do
      create(:match, position: 3)
      match_1 = create(:match, position: 1)
      create(:match, position: 2)

      subject.first_match.should eq match_1
    end
  end

  describe '#last_match' do

    it 'should return last match' do
      match_3 = create(:match, position: 3)
      create(:match, position: 1)
      create(:match, position: 2)

      subject.last_match.should eq match_3
    end
  end
end