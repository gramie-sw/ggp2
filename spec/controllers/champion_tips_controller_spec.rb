describe ChampionTipsController do

  let(:user) { create(:player) }
  let(:champion_tip) { create(:champion_tip, user: user) }

  before :each do
    sign_in user
  end

  describe '#edit' do

    it 'should return http success' do
      get :edit, id: champion_tip.to_param
      response.should be_success
    end

    it 'should render template edit' do
      get :edit, id: champion_tip.to_param
      response.should render_template :edit
    end

    it 'should assign correctly instantiated ChampionTipShowPresenter' do
      ChampionTipsEditPresenter.should_receive(:new).with(champion_tip).and_call_original
      get :edit, id: champion_tip.to_param
      assigns(:presenter).should be_kind_of ChampionTipsEditPresenter
    end
  end

  describe '#update' do

    let(:new_champion_tip_team_id) { champion_tip.team.id+1 }
    let(:params) { {id: champion_tip.id, champion_tip: {team_id: new_champion_tip_team_id}} }

    context 'on success' do

      before :each do
        ChampionTip.any_instance.stub(:valid?).and_return(true)
      end

      it 'should redirect to user_tips#show' do
        patch :update, params
        response.should redirect_to user_tip_path(user)
      end

      it 'should update champion_tip attributes' do
        patch :update, params
        champion_tip.reload
        champion_tip.team_id.should eq new_champion_tip_team_id
      end

      it 'should assign flash message' do
        patch :update, params
        flash[:notice].should eq t('model.messages.updated', model: ChampionTip.model_name.human)
      end
    end

    context 'on failure' do

      before :each do
        champion_tip
        ChampionTip.any_instance.stub(:valid?).and_return(false)
      end

      it 'should return http success' do
        patch :update, params
        response.should be_success
      end

      it 'should render template edit' do
        patch :update, params
        response.should render_template :edit
      end

      it 'should assign correctly instantiated ChampionTipShowPresenter' do
        ChampionTipsEditPresenter.should_receive(:new).with(champion_tip).and_call_original
        get :edit, id: champion_tip.to_param
        assigns(:presenter).should be_kind_of ChampionTipsEditPresenter
      end
    end
  end

end
