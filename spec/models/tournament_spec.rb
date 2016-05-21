describe Tournament, :type => :model do

  let(:first_match) { create(:match) }

  subject { Tournament.new }

  before :each do
    relation = double('MatchRelation')
    allow(relation).to receive(:first).and_return(first_match)
    allow(MatchQueries).to receive(:order_by_position_asc).and_return(relation)
  end

  describe 'title' do

    it 'returns the champion_title' do
      expect(PropertyQueries).to receive(:find_value).with(Property::TOURNAMENT_TITLE_KEY).and_return(:tournament_title)
      expect(subject.title).to be :tournament_title
    end
  end

  describe 'champion_title' do

    it 'returns the champion_title' do
      expect(PropertyQueries).to receive(:find_value).with(Property::CHAMPION_TITLE_KEY).and_return(:champion_title)
      expect(subject.champion_title).to be :champion_title
    end
  end

  describe '#started?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return true' do
          expect(first_match).to receive(:started?).and_return(true)
          expect(subject).to be_started
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          expect(first_match).to receive(:started?).and_return(false)
          expect(subject).not_to be_started
        end
      end
    end

    context 'if no match exists' do

      let(:first_match) { nil }

      it 'should return false' do
        expect(subject).not_to be_started
      end
    end
  end

  describe '#start_date' do

    context 'if matches exists' do

      it 'should return the date of the first match' do
        expect(subject.start_date).to eq first_match.date
      end
    end

    context 'if no matches exists' do

      let(:first_match) { nil }

      it 'should return the date of the first match' do
        expect(subject.start_date).to be_nil
      end
    end
  end

  describe '#champion_tip_deadline' do

    it 'should be alias of start_date' do
      expect(subject.method(:champion_tip_deadline).inspect).to match 'start_date'
    end
  end

  describe '#champion_tippable?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return false' do
          expect(first_match).to receive(:started?).and_return(true)
          expect(subject.champion_tippable?).to be_falsey
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          expect(first_match).to receive(:started?).and_return(false)
          expect(subject.champion_tippable?).to be_truthy
        end
      end
    end

    context 'if no match exist' do

      let(:first_match) { nil }

      it 'should return true' do
        expect(subject.champion_tippable?).to be_truthy
      end
    end
  end

  describe '#played_match_count' do

    it 'should return played match count' do
      expect(MatchQueries).to receive(:count_all_with_results).and_return(3)
      expect(subject.played_match_count).to eq 3
    end

    it 'should cache value' do
      expect(MatchQueries).to receive(:count_all_with_results).and_return(3)
      subject.played_match_count
      subject.played_match_count
    end
  end

  describe '#total_match_count' do

    it 'should return total match count' do
      expect(Match).to receive(:count).and_return(64)
      expect(subject.total_match_count).to eq 64
    end

    it 'should cache value' do
      expect(Match).to receive(:count).and_return(64)
      subject.total_match_count
      subject.total_match_count
    end
  end

  describe '#champion_team' do

    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:match) { Match.new(team_1: team_1, team_2: team_2, score_team_1: 1, score_team_2: 4) }

    it 'should return winner of last_match' do
      expect(MatchQueries).to receive(:last_match).and_return(match)
      expect(subject.champion_team).to eq team_2
    end

    it 'should cache champion_team' do
      expect(MatchQueries).to receive(:last_match).once.and_return(match)
      subject.champion_team
      subject.champion_team
    end
  end

  describe '#finished?' do

    let(:match) { build(:match) }

    before :each do
      allow(MatchQueries).to receive(:last_match).and_return(match)
    end

    context 'if last match has result' do

      it 'should return true' do

        allow(match).to receive(:has_result?).and_return(true)
        expect(subject.finished?).to be_truthy
      end
    end

    context 'if last match has no result' do

      it 'should return false' do

        allow(match).to receive(:has_result?).and_return(false)
        expect(subject.finished?).to be_falsey
      end
    end
  end

  describe '#current_phase' do

    let(:match) { double('Match') }

    before :each do
      allow(match).to receive(:phase).and_return(:current_phase)
    end

    context 'when next Match exists' do

      it 'should return phase of next match' do
        expect(MatchQueries).to receive(:next_match).and_return(match)
        expect(subject.current_phase).to be :current_phase
      end
    end

    context 'when next Match does not exist' do

      it 'should return phase of last match' do
        expect(MatchQueries).to receive(:next_match).and_return(nil)
        expect(MatchQueries).to receive(:last_match).and_return(match)
        expect(subject.current_phase).to be :current_phase
      end
    end

    it 'should cache return value' do
      expect(MatchQueries).to receive(:next_match).and_return(match)
      subject.current_phase
      subject.current_phase
    end
  end

  describe 'player_count' do

    it 'returns player count and caches value' do
      expect(UserQueries).to receive(:player_count).and_return(34)
      expect(subject.player_count).to be 34

      #tests that value is cached
      subject.player_count
    end
  end

  describe 'highest_match_position_with_result' do

    it 'returns highest position of match with result and caches value' do
      expect(MatchQueries).to receive(:highest_match_position_with_result).and_return(34)
      expect(subject.highest_match_position_with_result).to be 34

      #tests that value is cached
      subject.highest_match_position_with_result
    end
  end
end