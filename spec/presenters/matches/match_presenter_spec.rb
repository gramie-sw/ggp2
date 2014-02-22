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

    let(:match) { create(:match, aggregate: aggregate) }

    context 'if match belongs only to phase' do
      let(:aggregate) { create(:phase) }

      it 'should return phase name' do
        subject.aggregate_name_recursive.should eq aggregate.name
      end
    end

    context 'if match belongs to group' do
      let(:aggregate) { create(:group) }

      it 'should return phase name' do
        subject.aggregate_name_recursive.should eq "#{aggregate.parent.name} - #{aggregate.name}"
      end
    end
  end
end