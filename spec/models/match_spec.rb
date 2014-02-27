describe Match do

  it 'should have valid factory' do
    build(:match).should be_valid
  end

  describe 'validations' do
    describe '#position' do
      it { should validate_presence_of(:position) }
      it { should validate_uniqueness_of(:position) }
      it { should validate_numericality_of(:position).only_integer }
      it { should ensure_inclusion_of(:position).in_range(1..1000) }
    end

    describe '#aggregate' do
      it { should validate_presence_of(:aggregate_id) }
      it { should validate_presence_of(:aggregate) }
    end

    describe '#team_1' do
      context 'team_1_id is set' do
        before { subject.stub(:team_1_id).and_return(1) }
        it { subject.should validate_presence_of(:team_1) }
      end

      context 'team_1_id is not set' do
        before { subject.stub(:team_1_id).and_return(nil) }
        it { subject.should_not validate_presence_of(:team_1) }
      end
    end

    describe '#team_2' do
      context 'team_2_id is set' do
        before { subject.stub(:team_2_id).and_return(1) }
        it { subject.should validate_presence_of(:team_2) }
      end

      context 'team_1_id is not set' do
        before { subject.stub(:team_2_id).and_return(nil) }
        it { subject.should_not validate_presence_of(:team_2) }
      end
    end

    describe '#placeholder_team_1' do
      it { should ensure_length_of(:placeholder_team_1).is_at_least(3).is_at_most(64) }
      it { should_not allow_value('Test%').for(:placeholder_team_1) }

      it 'should allow blank if team_1 is set' do
        build(:match, placeholder_team_1: '').should be_valid
      end

      it 'should not allow blank if team_1 is not set' do
        build(:match, team_1_id: 0, placeholder_team_1: '').should_not be_valid
      end
    end

    describe '#placeholder_team_2' do
      it { should ensure_length_of(:placeholder_team_2).is_at_least(3).is_at_most(64) }
      it { should_not allow_value('Test%').for(:placeholder_team_2) }

      it 'should allow blank if team_2 is set' do
        build(:match, placeholder_team_2: '').should be_valid
      end

      it 'should not allow blank if team_2 is not set' do
        build(:match, team_1_id: 0, placeholder_team_2: '').should_not be_valid
      end
    end

    describe '#date' do
      it { should validate_presence_of(:date) }
    end

    it 'should validate_dummy_team_1_not_equals_dummy_team_2_besides_nil_or_blank' do
      build(:match, placeholder_team_1: 'dummy', placeholder_team_2: 'dummy').should_not be_valid
      build(:match, placeholder_team_1: nil, placeholder_team_2: nil).should be_valid
      build(:match, placeholder_team_1: '', placeholder_team_2: '').should be_valid
    end

    it 'should validate_team_1_not_equal_team_2' do
      team = create(:team)
      build(:match, team_1_id: team.id, team_2_id: team.id).should_not be_valid
      build(:match, team_1_id: team.id, team_2_id: create(:team).id).should be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:aggregate) }
    it { should belong_to(:team_1).class_name('Team') }
    it { should belong_to(:team_2).class_name('Team') }
    it { should have_many(:tips).dependent(:destroy) }
  end

  describe 'scopes' do

    describe '::order_by_position' do

      it 'should order by position' do
        aggregate = create(:aggregate)

        game_3 = create(:match, aggregate: aggregate, position: 3)
        game_1 = create(:match, aggregate: aggregate, position: 1)
        game_2 = create(:match, aggregate: aggregate, position: 2)

        games = Match.order_by_position
        games[0].position.should eq game_1.position
        games[1].position.should eq game_2.position
        games[2].position.should eq game_3.position
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
    end

  describe '#team_1?' do
    it 'returns true when match has team_1' do
      team = build(:team)
      game = build(:match, team_1: team)
      game.team_1?.should be_true
    end

    it 'returns false when match has no team_1' do
      build(:match, team_1: nil).team_1?.should be_false
    end
  end

  describe '#team_2?' do
    it 'returns true when match has team_2' do
      team = build(:team)
      game = build(:match, team_2: team)
      game.team_2?.should be_true
    end

    it 'returns false when match has no team_2' do
      build(:match, team_2: nil).team_2?.should be_false
    end
  end

  describe '#has_result?' do

    context 'if score_team_1 and score_team_2 present' do

      it 'should return true' do
        subject.score_team_1 = 0
        subject.score_team_2 = 1
        subject.has_result?.should be_true
      end
    end

    context 'if only score_team_1 present' do

      it 'should return false' do
        subject.score_team_1 = 0
        subject.score_team_2 = nil
        subject.has_result?.should be_false
      end
    end

    context 'if only score_team_2 present' do

      it 'should return false' do
        subject.score_team_2 = 0
        subject.has_result?.should be_false
      end
    end

    context 'if score_team_1 and score_team_2 present' do

      it 'should return false' do
        subject.has_result?.should be_false
      end
    end
  end

  describe '#started?' do

    context 'if date is in the past' do
      subject { Match.new date: 1.minute.ago }
      it 'should return true' do
        subject.should be_started
      end
    end

    context 'if date is not in the past' do
      subject { Match.new date: 1.minute.from_now }
      it 'should return false' do
        subject.should_not be_started
      end
    end
  end
end
