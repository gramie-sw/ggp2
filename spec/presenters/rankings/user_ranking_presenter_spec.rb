describe UserRankingPresenter do

  let(:user) { User.new(id: 7) }
  let(:ranking_item) { RankingItem.new(user: user) }
  let(:tournament) { Tournament.new }
  let(:current_user_id) { 5 }

  subject do
    UserRankingPresenter.new(
        ranking_item: ranking_item,
        tournament: tournament,
        current_user_id: current_user_id)
  end

  it 'should delegate User methods to RankingItem#user' do
    user.nickname = 'user_1'
    user.titleholder = true
    expect(user).to receive(:badges_count).and_return(5)

    expect(subject.nickname).to eq 'user_1'
    expect(subject.titleholder?).to be_truthy
    expect(subject.badges_count).to eq 5
  end

  it 'should delegate RankingItem methods to RankingItem' do
    ranking_item.user_id = 344
    ranking_item.position = 5
    ranking_item.points = 67
    ranking_item.correct_tips_count = 7
    ranking_item.correct_tendeny_tips_count = 11

    expect(subject.user_id).to eq 344
    expect(subject.position).to eq 5
    expect(subject.points).to eq 67
    expect(subject.correct_tips_count).to eq 7
    expect(subject.correct_tendeny_tips_count).to eq 11
  end

  describe 'champion_tip_team_name' do

    let(:expected_team_name) { 'team_1' }
    let(:champion_tip) { ChampionTip.new(team: Team.new(id: 4)) }

    before :each do
      user.champion_tip = champion_tip
      allow(champion_tip.team).to receive(:name).and_return(expected_team_name)
    end

    context 'when ChampionTip team is present' do

      context 'when user_id of RankingItem equals current_user_id' do

        let(:current_user_id) { user.id }

        it 'should return ChampionTip team name' do
          expect(tournament).to receive(:started?).never
          expect(subject.champion_tip_team_name).to eq expected_team_name
        end
      end

      context 'when user_id of RankingItem does not equal current_user_id' do

        let(:current_user_id) { user.id+1 }

        context 'when tournament is started' do

          it 'should  return ChampionTip team name' do
            allow(tournament).to receive(:started?).at_least(:once).and_return(true)
            expect(subject.champion_tip_team_name).to eq expected_team_name
          end
        end

        context 'when tournament is not started' do

          it 'should return present placeholder' do
            allow(tournament).to receive(:started?).and_return(false)
            expect(subject.champion_tip_team_name).to eq '***'
          end
        end
      end
    end

    context 'when ChampionTip team is not present' do

      it 'should return nil' do
        champion_tip.team = nil
        expect(tournament).to receive(:started?).never
        expect(subject.champion_tip_team_name).to eq t('tip.not_present')
      end
    end
  end


  describe 'champion_tip_team_abbreviation' do

    let(:expected_team_abbreviation) { 't1' }
    let(:champion_tip) { ChampionTip.new(team: Team.new(id: 4)) }

    before :each do
      user.champion_tip = champion_tip
      allow(champion_tip.team).to receive(:abbreviation).and_return(expected_team_abbreviation)
    end

    context 'when ChampionTip team is present' do

      context 'when user_id of RankingItem equals current_user_id' do

        let(:current_user_id) { user.id }

        it 'should return ChampionTip team name' do
          expect(tournament).to receive(:started?).never
          expect(subject.champion_tip_team_abbreviation).to eq expected_team_abbreviation
        end
      end

      context 'when user_id of RankingItem does not equal current_user_id' do

        let(:current_user_id) { user.id+1 }

        context 'when tournament is started' do

          it 'should  return ChampionTip team name' do
            allow(tournament).to receive(:started?).at_least(:once).and_return(true)
            expect(subject.champion_tip_team_abbreviation).to eq expected_team_abbreviation
          end
        end

        context 'when tournament is not started' do

          it 'should return nil' do
            allow(tournament).to receive(:started?).and_return(false)
            expect(subject.champion_tip_team_abbreviation).to be_nil
          end
        end
      end
    end

    context 'when ChampionTip team is not present' do

      it 'should return nil' do
        champion_tip.team = nil
        expect(tournament).to receive(:started?).never
        expect(subject.champion_tip_team_abbreviation).to be_nil
      end
    end
  end
end