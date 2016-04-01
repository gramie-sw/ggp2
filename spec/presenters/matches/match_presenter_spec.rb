describe MatchPresenter do

  let(:match) { Match.new }
  subject { MatchPresenter.new(match) }

  describe '#team_1_code' do

    it 'returns team 1 code or nil' do
      expect(subject.team_1_code).to be nil

      match.team_1 = Team.new(country: 'NL')
      expect(subject.team_1_code).to eq 'NL'
    end
  end
  
  describe '#team_2_code' do

    it 'returns team 2 code or nil' do
      expect(subject.team_2_code).to be nil

      match.team_2 = Team.new(country: 'NL')
      expect(subject.team_2_code).to eq 'NL'
    end
  end

  it 'should include ResultPresentable' do
    expect(MatchPresenter.included_modules).to include ResultPresentable
  end

  describe '#team_1_name_or_placeholder' do

    context 'if match has team_1' do

      it 'should return team 1 name' do
        expected_team = create(:team)
        match.team_1 = expected_team
        expect(subject.team_1_name_or_placeholder).to eq expected_team.name
      end
    end

    context 'if match has no team_1' do

      it 'should return placeholder' do
        match.placeholder_team_1= 'team_1'
        match.team_1 = nil
        expect(subject.team_1_name_or_placeholder).to eq 'team_1'
      end
    end
  end

  describe '#team_2_name_or_placeholder' do

    context 'if match has team_2' do

      it 'should return team 2 name' do
        expected_team = create(:team)
        match.team_2 = expected_team
        expect(subject.team_2_name_or_placeholder).to eq expected_team.name
      end
    end

    context 'if match has no team_2' do

      it 'should return placeholder' do
        match.placeholder_team_2= 'team_2'
        match.team_2 = nil
        expect(subject.team_2_name_or_placeholder).to eq 'team_2'
      end
    end
  end

  describe 'aggregate_name_recursive' do

    let(:aggregate) { create(:aggregate) }
    let(:match) { create(:match, aggregate: aggregate) }

    context 'if match belongs only to phase' do
      let(:aggregate) { create(:phase) }

      context 'if multiline is false' do

        it 'should return phase name' do
          expect(subject.aggregate_name_recursive).to eq aggregate.name
        end
      end

      context 'if multiline is ture' do

        it 'should return array with phase name' do
          expect(subject.aggregate_name_recursive(multiline: true)).to eq [aggregate.name]
        end
      end
    end

    context 'if match belongs to group' do
      let(:aggregate) { create(:group) }

      context 'if multiline is false' do

        it 'should return phase and group name' do
          expect(subject.aggregate_name_recursive).to eq "#{aggregate.parent.name} - #{aggregate.name}"
        end
      end

      context 'if multiline is false' do

        it 'should return Array with phase and group name' do
          expect(subject.aggregate_name_recursive(multiline: true)).to eq [aggregate.parent.name, aggregate.name]
        end
      end
    end

    it 'should cache return value' do
      expect(subject.aggregate_name_recursive).to be subject.aggregate_name_recursive
    end
  end
end