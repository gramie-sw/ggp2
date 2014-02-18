describe MatchPresenter do

  let(:match) { create(:match) }
  subject { MatchPresenter.new(match) }

  describe '#position' do

    it 'should return position with dot' do
      subject.position.should eq "#{match.position}."
    end
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

  describe '#result' do

    context 'if match has result' do

      it 'should return formatted result' do

        match.stub(:has_result?).and_return(true)
        match.score_team_1 = 1
        match.score_team_2 = 2
        subject.result.should eq '1 : 2'
      end
    end

    context 'if match has no result' do

      it 'should return formatted result placeholder' do
        match.stub(:has_result?).and_return(false)
        subject.result.should eq '- : -'
      end
    end
  end
end