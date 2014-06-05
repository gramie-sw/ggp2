describe TipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#edit_multiple' do

    context 'if tip_ids present' do

      let(:params) { {tip_ids: ['1', '2', '3']} }

      it 'should return http success' do
        post :edit_multiple, params
        response.should be_success
      end

      it 'should render template edit_multiple' do
        post :edit_multiple, params
        response.should render_template(:edit_multiple)
      end

      it 'should assign TipsEditMultiplePresenter' do
        TipsEditMultiplePresenter.should_receive(:new).with(tip_ids: params[:tip_ids]).and_call_original
        post :edit_multiple, params
        assigns(:presenter).should be_kind_of TipsEditMultiplePresenter
      end
    end

    context 'if tip_ids not present' do

      let(:params) { {} }

      before :each do
        @request.stub(:referer).and_return(user_tip_path(player))
      end

      it 'should redirect to referer_path' do
        post :edit_multiple, params
        response.should redirect_to user_tip_path(player)
      end

      it 'should assign alert message' do
        post :edit_multiple, params
        flash[:alert].should eq t('general.none_selected', element: Tip.model_name.human)
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
      Tip.stub(:update_multiple).and_return(result)
    end

    it 'should call Tip#update_multiple with correct arguments' do
      Tip.should_receive(:update_multiple).with(params[:tips]).and_call_original
      post :update_multiple, params
    end

    context 'on success' do

      it 'should redirect to user_tip_path for current_user' do
        post :update_multiple, params
        response.should redirect_to user_tip_path(player)
      end

      it 'should assign flash message' do
        post :update_multiple, params
        flash[:notice].should eq t('model.messages.count.saved',
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
        post :update_multiple, params
        response.should be_success
      end

      it 'should render edit_multiple' do
        post :update_multiple, params
        response.should render_template :edit_multiple
      end

      it 'should assign TipsEditMultiplePresenter' do
        TipsEditMultiplePresenter.should_receive(:new).with(tips: result.failed_records).and_call_original
        post :update_multiple, params
        assigns(:presenter).should be_kind_of TipsEditMultiplePresenter
      end

      context 'if a least one tip was valid' do

        it 'should assign flash message for succeeded tips' do
          post :update_multiple, params
          flash.now[:notice].should eq t('model.messages.count.saved',
                                         models: Tip.model_name.human(count: result.succeeded_records.count),
                                         count: result.succeeded_records.count
                                       )
        end
      end

      context 'if no tip was valid' do

        it 'should assign flash message for succeeded tips' do
          result.succeeded_records = []
          post :update_multiple, params
          flash.now[:notice].should be_nil
        end
      end

    end
  end
end
