describe UserTipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it "returns http success" do
      get :show, id: player.to_param
      response.should be_success
    end
  end

end
