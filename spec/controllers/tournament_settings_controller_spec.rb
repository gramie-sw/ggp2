describe TournamentSettingsController, type: :controller do

  before :each do
    create_and_sign_in :admin
  end

  describe '#edit' do

    it 'assigns tournament_settings_form and renders show' do
      tournament_settings_form = TournamentSettingsForm.new
      expect(TournamentSettings::CreateForm).to receive(:run).and_return(tournament_settings_form)

      get :edit
      expect(assigns(:tournament_settings_form)).to be tournament_settings_form
      expect(response).to render_template :edit
    end
  end

  describe '#update' do

    let(:tournament_settings_form) { TournamentSettingsForm.new }
    let(:params) { {tournament_settings: 'tournament_settings_values'} }

    before :each do
      allow(TournamentSettings::Update).to receive(:run).and_return(tournament_settings_form)
    end

    it 'calls TournamentSettings::Update' do
      expect(TournamentSettings::Update).
          to receive(:run).with(tournament_settings_attributes: params[:tournament_settings]).
                 and_return(tournament_settings_form)

      patch :update, params
    end

    describe 'on success' do

      it 'assigns flash message and redirects to edit' do
        patch :update, params
        expect(response).to redirect_to(edit_tournament_settings_path)
        expect(flash[:notice]).to eq t('model.messages.updated', model: t('general.settings'))
      end
    end

    describe 'on failure' do

      before :each do
        tournament_settings_form.errors.add(:base, 'error')
      end

      it 'assigns form and render edit' do
        patch :update, params
        expect(response).to render_template(:edit)
        expect(assigns(:tournament_settings_form)).to be tournament_settings_form
      end
    end
  end

end