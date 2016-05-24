describe MatchResultsController, :type => :controller do

  let(:admin) { create(:admin) }

  before :each do
    sign_in admin
  end

  describe '#edit' do

    match_id = '78'

    it 'assigns MatchResultPresenter and renders edit' do
      get :edit, id: match_id

      expect(response).to be_success
      expect(response).to render_template :edit
      expect(assigns(:presenter)).to be_instance_of MatchResultPresenter
      expect(assigns(:presenter).match_id).to be match_id
    end
  end

  describe '#udpate' do

    describe 'calls MatchResults::Update and' do

      let(:match) { Match.new(position: 1, aggregate_id: 34) }
      let(:match_result) { MatchResult.new(match: match) }

      let(:params) { {id: '98', match_result: {'score_team_1' => '1', 'score_team_2' => '2'}} }


      before :each do
        expect(MatchResults::Update).to receive(:run).
            with(match_id: params[:id], match_result_attributes: params[:match_result]).
            and_return(match_result)
      end

      context 'on success' do

        it 'redirects to match_schedule_path' do
          patch :update, params, {Ggp2::MATCH_SCHEDULE_LAST_SHOWN_AGGREGATE_ID_KEY => match.aggregate_id}

          expect(response).to redirect_to match_schedules_path(aggregate_id: match.aggregate_id)
          expect(flash[:notice]).to eq t('model.messages.updated', model: match_result.message_name)
        end
      end

      context 'on failure' do

        before :each do
          match_result.errors.add(:add, 'message')
        end

        it 'assigns MatchResultPresenter and renders edit' do
          patch :update, params

          expect(response).to be_success
          expect(response).to render_template :edit
          expect(assigns(:presenter)).to be_instance_of MatchResultPresenter
          expect(assigns(:presenter).match_result).to eq match_result
        end
      end
    end
  end

  describe '#destroy' do

    it 'calls MatchResults::Delete and redirects to match_schedule_path' do
      match_id = '98'
      expect(MatchResults::Delete).to receive(:run).with(match_id: match_id)

      delete :destroy, id: match_id
      expect(response).to redirect_to(match_schedules_path)
      expect(flash[:notice]).to eq t('model.messages.destroyed', model: t('match.result'))

    end
  end
end