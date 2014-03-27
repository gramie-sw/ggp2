describe CommentsController do

  let(:user) { create(:player) }

  before :each do
    sign_in user
  end

  describe '#new' do

    it 'should return http success' do
      get :new
      response.should be_success
    end

    it 'should render template new' do
      get :new
      response.should render_template :new
    end

    it 'should assign correctly instantiated Comment' do
      Comment.should_receive(:new).with(user_id: user.id).and_return(:new_comment)
      get :new
      assigns(:comment).should eq :new_comment
    end
  end
end