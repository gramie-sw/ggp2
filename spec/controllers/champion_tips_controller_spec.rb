describe ChampionTipsController, :type => :controller do

  let(:user) { create(:player) }
  let(:champion_tip) { create(:champion_tip, user: user) }

  before :each do
    sign_in user
  end

  describe '#edit' do

    it 'should return http success' do
      get :edit, id: champion_tip.to_param
      expect(response).to be_success
    end

    it 'should render template edit' do
      get :edit, id: champion_tip.to_param
      expect(response).to render_template :edit
    end

    it 'should assign correctly instantiated ChampionTipShowPresenter' do
      expect(ChampionTipsEditPresenter).to receive(:new).with(champion_tip).and_call_original
      get :edit, id: champion_tip.to_param
      expect(assigns(:presenter)).to be_kind_of ChampionTipsEditPresenter
    end
  end

  describe '#update' do

    let(:champion_title) {'World Champion'}
    let(:new_champion_tip_team_id) { champion_tip.team.id+1 }
    let(:params) { {id: champion_tip.id, champion_tip: {team_id: new_champion_tip_team_id}} }

    context 'on success' do

      before :each do
        expect(@controller).to respond_to(:champion_title)
        allow(@controller). to receive(:champion_title).and_return(champion_title)
        allow_any_instance_of(ChampionTip).to receive(:valid?).and_return(true)
      end

      it 'should redirect to user_tips#show' do
        patch :update, params
        expect(response).to redirect_to user_tip_path(user)
      end

      it 'should update champion_tip attributes' do
        patch :update, params
        champion_tip.reload
        expect(champion_tip.team_id).to eq new_champion_tip_team_id
      end

      it 'should assign flash message' do
        patch :update, params
        expect(flash[:notice]).to eq t('model.messages.updated',
                                       model: t('general.champion_tip.one', champion_title: champion_title))

      end
    end

    context 'on failure' do

      before :each do
        champion_tip
        allow_any_instance_of(ChampionTip).to receive(:valid?).and_return(false)
      end

      it 'should return http success' do
        patch :update, params
        expect(response).to be_success
      end

      it 'should render template edit' do
        patch :update, params
        expect(response).to render_template :edit
      end

      it 'should assign correctly instantiated ChampionTipShowPresenter' do
        expect(ChampionTipsEditPresenter).to receive(:new).with(champion_tip).and_call_original
        get :edit, id: champion_tip.to_param
        expect(assigns(:presenter)).to be_kind_of ChampionTipsEditPresenter
      end
    end
  end
end
