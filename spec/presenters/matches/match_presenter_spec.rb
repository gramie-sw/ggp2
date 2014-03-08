describe MatchPresenter do

  let(:match) { create(:match) }
  subject { MatchPresenter.new(match) }

  it 'should include ResultPresentable' do
    MatchPresenter.included_modules.should include ResultPresentable
  end

  describe '#team_1_name_or_placeholder' do

    context 'if match has team_1' do

      it 'should return team 1 name' do
        expected_team = create(:team)
        match.team_1 = expected_team
        subject.team_1_name_or_placeholder.should eq expected_team.name
      end
    end

    context 'if match has no team_1' do

      it 'should return placeholder' do
        match.placeholder_team_1= :team_1
        match.team_1 = nil
        subject.team_1_name_or_placeholder.should be :team_1
      end
    end
  end

  describe '#team_2_name_or_placeholder' do

    context 'if match has team_2' do

      it 'should return team 2 name' do
        expected_team = create(:team)
        match.team_2 = expected_team
        subject.team_2_name_or_placeholder.should eq expected_team.name
      end
    end

    context 'if match has no team_2' do

      it 'should return placeholder' do
        match.placeholder_team_2= :team_2
        match.team_2 = nil
        subject.team_2_name_or_placeholder.should be :team_2
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
          subject.aggregate_name_recursive.should eq aggregate.name
        end
      end

      context 'if multiline is ture' do

        it 'should return array with phase name' do
          subject.aggregate_name_recursive(multiline: true).should eq [aggregate.name]
        end
      end
    end

    context 'if match belongs to group' do
      let(:aggregate) { create(:group) }

      context 'if multiline is false' do

        it 'should return phase and group name' do
          subject.aggregate_name_recursive.should eq "#{aggregate.parent.name} - #{aggregate.name}"
        end
      end

      context 'if multiline is false' do

        it 'should return Array with phase and group name' do
          subject.aggregate_name_recursive(multiline: true).should eq [aggregate.parent.name, aggregate.name]
        end
      end
    end

    it 'should cache return value' do
      subject.aggregate_name_recursive.should be subject.aggregate_name_recursive
    end
  end
end