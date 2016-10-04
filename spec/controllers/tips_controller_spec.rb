describe TipsController, :type => :controller do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#edit_multiple' do

    context 'if tip_ids present' do

      let(:params) { {tip_ids: ['1', '2', '3']} }

      it 'should return http success' do
        post :edit_multiple, params: params
        expect(response).to be_success
      end

      it 'should render template edit_multiple' do
        post :edit_multiple, params: params
        expect(response).to render_template(:edit_multiple)
      end

      it 'should assign TipsEditMultiplePresenter' do
        expect(TipsEditMultiplePresenter).to receive(:new).
            with(tip_ids: params[:tip_ids]).
            and_call_original
        post :edit_multiple, params: params
        expect(assigns(:presenter)).to be_kind_of TipsEditMultiplePresenter
      end
    end

    context 'if tip_ids not present' do

      let(:params) { {} }

      before :each do
        @request.env['HTTP_REFERER'] = user_tip_path(player)
      end

      it 'should redirect to referer_path' do
        post :edit_multiple, params: params
        expect(response).to redirect_to user_tip_path(player)
      end

      it 'should assign alert message' do
        post :edit_multiple, params: params
        expect(flash[:alert]).to eq t('general.none_selected', element: Match.model_name.human)
      end
    end
  end

  describe '#update multiple' do

    let(:tips) { (1..3).map { |p| create(:tip, score_team_1: 4, score_team_2: 4, user: player) } }
    let(:params) do
      {tips: {
          tips.first.to_param => {'score_team_1' => '1', 'score_team_2' => '0'},
          tips.second.to_param => {'score_team_1' => '2', 'score_team_2' => '0'},
          tips.third.to_param => {'score_team_1' => '3', 'score_team_2' => '0'}
      }
      }
    end
    let(:result) do
      result = RecordBatchUpdatable::Result.new
      result.no_errors = true
      result.succeeded_records = tips
      result
    end

    before :each do
      allow(Tip).to receive(:update_multiple).and_return(result)
    end

    it 'should call Tip#update_multiple with correct arguments' do
      expect(Tip).to receive(:update_multiple).
          with(ActionController::Parameters.new(params[:tips]).permit!).
          and_call_original
      post :update_multiple, params: params
    end

    context 'on success' do

      it 'should redirect to user_tip_path for current_user' do
        current_aggregate_id = 2
        @controller.session[Ggp2::USER_TIPS_LAST_SHOWN_AGGREGATE_ID_KEY] = current_aggregate_id
        post :update_multiple, params: params
        expect(response).to redirect_to user_tip_path(player, aggregate_id: current_aggregate_id)
      end

      it 'should assign flash message' do
        post :update_multiple, params: params
        expect(flash[:notice]).to eq t('model.messages.count.saved',
                                       models: Tip.model_name.human(count: tips.count),
                                       count: tips.count
                                     )
      end
    end

    context 'on failed' do

      let(:result) do
        result = RecordBatchUpdatable::Result.new
        result.no_errors = false
        result.succeeded_records = tips.values_at(1)
        result.failed_records = tips.values_at(0, 2)
        result
      end

      it 'should return http success' do
        post :update_multiple, params: params
        expect(response).to be_success
      end

      it 'should render edit_multiple' do
        post :update_multiple, params: params
        expect(response).to render_template :edit_multiple
      end

      it 'should assign TipsEditMultiplePresenter' do
        expect(TipsEditMultiplePresenter).to receive(:new).
            with(tips: result.failed_records).and_call_original
        post :update_multiple, params: params
        expect(assigns(:presenter)).to be_kind_of TipsEditMultiplePresenter
      end

      context 'if a least one tip was valid' do

        it 'should assign flash message for succeeded tips' do
          post :update_multiple, params: params
          expect(flash.now[:notice]).to eq t('model.messages.count.saved',
                                             models: Tip.model_name.human(count: result.succeeded_records.count),
                                             count: result.succeeded_records.count
                                           )
        end
      end

      context 'if no tip was valid' do

        it 'should assign flash message for succeeded tips' do
          result.succeeded_records = []
          post :update_multiple, params: params
          expect(flash.now[:notice]).to be_nil
        end
      end

    end
  end
end
