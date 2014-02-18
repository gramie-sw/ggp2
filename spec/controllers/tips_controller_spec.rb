describe TipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#edit_multiple' do

    let(:params) { {tip_id: ['1', '2', '3']} }

    it 'should return http success' do
      post :edit_multiple, params
      response.should be_success
    end

    it 'should render template edit_multiple' do
      post :edit_multiple, params
      response.should render_template(:edit_multiple)
    end

    it 'should assign TipsEditMultiplePresenter' do
      TipsEditMultiplePresenter.should_receive(:new).with(params[:tip_ids]).and_call_original
      post :edit_multiple, params
      assigns(:presenter).should be_kind_of TipsEditMultiplePresenter
    end
  end

end
