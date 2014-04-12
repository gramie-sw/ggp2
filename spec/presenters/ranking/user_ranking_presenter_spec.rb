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

  it 'should delegate nickname to RankingItem#user' do
    user.nickname = 'user_1'
    subject.nickname.should eq 'user_1'
  end

  it 'should delegate RankingItem methods to RankingItem' do
    ranking_item.user_id = 344
    ranking_item.position = 5
    ranking_item.points = 67
    ranking_item.correct_tips_count = 7
    ranking_item.correct_tendency_tips_only_count = 11

    subject.user_id.should eq 344
    subject.position.should eq 5
    subject.points.should eq 67
    subject.correct_tips_count.should eq 7
    subject.correct_tendency_tips_only_count.should eq 11
  end

#   describe 'champion_tip_team_name' do
#
#     let(:expected_team_name) {'team_1'}
#     let(:champion_tip) { ChampionTip.new(team: Team.new(id: 4)) }
#
#     before :each do
#       user.champion_tip = champion_tip
#       champion_tip.team.stub(:name).and_return(expected_team_name)
#     end
#
#     context 'when user_id of RankingItem equals current_user_id' do
#
#       let(:current_user_id) { user.id }
#
#       it 'should return ChampionTip' do
#         subject.champion_tip_team.should eq champion_tip.team
#       end
#     end
#
#     context 'when user_id of RankingItem does not equal current_user_id' do
#
#       let(:current_user_id) { user.id+1 }
#
#       context 'when tournament is started' do
#
#         it 'should return ChampionTip' do
#           tournament.should_receive(:started?).and_return(true)
#           subject.champion_tip_team.should eq champion_tip.team
#         end
#       end
#
#       context 'when tournament is not started' do
#
#         context 'when ChampionTip team is present' do
#
#           it 'should return nil' do
#             tournament.should_receive(:started?).and_return(false)
#             subject.champion_tip_team.should be_nil
#           end
#         end
#       end
#     end
#   end
end