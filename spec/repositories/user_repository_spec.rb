describe UserRepository do

  subject { User }

  describe 'players_for_ranking_listing' do

    it 'should return all users being players paginated' do
      create(:admin)
      expected_user_1 = create(:player)
      expected_user_2 = create(:player)
      create(:player)

      actual_users = subject.players_for_ranking_listing(page: 1, per_page: 2)
      actual_users.count.should eq 2
      actual_users.should include expected_user_1, expected_user_2
    end
  end

  it 'should includes champion_tip and team' do
    relation = double('UserRelation')
    relation.as_null_object

    subject.should_receive(:players).and_return(relation)
    relation.should_receive(:includes).with(champion_tip: :team)

    subject.players_for_ranking_listing(page: nil, per_page: nil)
  end
end