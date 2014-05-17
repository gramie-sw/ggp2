describe Tournament do

  let(:first_match) { create(:match) }

  subject { Tournament.new }

  before :each do
    relation = double('MatchRelation')
    relation.stub(:first).and_return(first_match)
    Match.stub(:order_by_position).and_return(relation)
  end

  describe '#started?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return true' do
          first_match.should_receive(:started?).and_return(true)
          subject.should be_started
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(false)
          subject.should_not be_started
        end
      end
    end

    context 'if no match exists' do

      let(:first_match) { nil }

      it 'should return false' do
        subject.should_not be_started
      end
    end
  end

  describe '#start_date' do

    context 'if matches exists' do

      it 'should return the date of the first match' do
        subject.start_date.should eq first_match.date
      end
    end

    context 'if no matches exists' do

      let(:first_match) { nil }

      it 'should return the date of the first match' do
        subject.start_date.should be_nil
      end
    end
  end

  describe '#champion_tip_deadline' do

    it 'should be alias of start_date' do
      subject.method(:champion_tip_deadline).inspect.should match 'start_date'
    end
  end

  describe '#champion_tippable?' do

    context 'if matches exists' do

      context 'if first match is started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(true)
          subject.champion_tippable?.should be_false
        end
      end

      context 'if first match is not started' do

        it 'should return false' do
          first_match.should_receive(:started?).and_return(false)
          subject.champion_tippable?.should be_true
        end
      end
    end

    context 'if no match exist' do

      let(:first_match) { nil }

      it 'should return true' do
        subject.champion_tippable?.should be_true
      end
    end
  end

  describe '#played_match_count' do

    it 'should return played match count' do
      Match.should_receive(:count_all_with_results).and_return(3)
      subject.played_match_count.should eq 3
    end

    it 'should cache value' do
      Match.should_receive(:count_all_with_results).and_return(3)
      subject.played_match_count
      subject.played_match_count
    end
  end

  describe '#total_match_count' do

    it 'should return total match count' do
      Match.should_receive(:count).and_return(64)
      subject.total_match_count.should eq 64
    end

    it 'should cache value' do
      Match.should_receive(:count).and_return(64)
      subject.total_match_count
      subject.total_match_count
    end
  end

  describe '#champion_team' do

    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    let(:match) { Match.new(team_1: team_1, team_2: team_2, score_team_1: 1, score_team_2: 4) }

    it 'should return winner of last_match' do
      Match.should_receive(:last_match).and_return(match)
      subject.champion_team.should eq team_2
    end

    it 'should cache champion_team' do
      Match.should_receive(:last_match).once.and_return(match)
      subject.champion_team
      subject.champion_team
    end
  end

  describe '#finished?' do

    let(:match) { build(:match)}

    before :each do
      Match.stub(:last_match).and_return(match)
    end

    context 'if last match has result' do

      it 'should return true' do

        match.stub(:has_result?).and_return(true)
        subject.finished?.should be_true
      end
    end

    context 'if last match has no result' do

      it'should return false' do

        match.stub(:has_result?).and_return(false)
        subject.finished?.should be_false
      end
    end
  end

  describe '#current_phase' do

    before :each do
      next_match = double('Match')
      expect(Match).to receive(:next_match).and_return(next_match)
      expect(next_match).to receive(:phase).and_return(:current_phase)
    end

    it 'should return phase of next match' do
      expect(subject.current_phase).to be :current_phase
    end

    it 'should cache return value' do
      subject.current_phase
      subject.current_phase
    end
  end
end
