describe ChampionTipsController, :type => :controller do

  let(:user) { create(:player) }
  let(:champion_tip) { create(:champion_tip, user: user) }

  before :each do
    sign_in user
  end

  describe '#edit' do

    it 'assigns ChampionTipShowPresenter and renders edit' do
      get :edit, id: champion_tip.to_param

      expect(response).to be_success
      expect(response).to render_template :edit
      expect(assigns(:presenter)).to be_instance_of ChampionTipsEditPresenter
      expect(assigns(:presenter).champion_tip).to eq champion_tip
    end
  end

  describe '#update' do

    describe 'calls ChampionTips::SetTeam and' do

      let(:params) { {id: champion_tip.to_param, champion_tip: {team_id: '78'}} }

      before :each do
        expect(ChampionTips::SetTeam).
            to receive(:run).with(id: params[:id], team_id: params[:champion_tip][:team_id]).and_return(champion_tip)
      end

      describe 'on success' do

        it 'assigns message and redirects to user tip path' do
          champion_title = 'World Champion'
          expect(@controller).to respond_to(:champion_title)
          allow(@controller).to receive(:champion_title).and_return(champion_title)

          patch :update, params

          expect(response).to redirect_to user_tip_path(user)
          expect(flash[:notice]).to eq t('model.messages.updated',
                                         model: t('general.champion_tip.one', champion_title: champion_title))
        end
      end

      describe 'on failure' do

        before :each do
          champion_tip.errors.add(:base, 'message')
        end

        it 'assigns ChampionTipShowPresenter and renders edit' do
          patch :update, params

          expect(response).to be_success
          expect(response).to render_template :edit
          expect(assigns(:presenter)).to be_instance_of ChampionTipsEditPresenter
          expect(assigns(:presenter).champion_tip).to eq champion_tip
        end
      end
    end
  end
end
