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

  describe '#create' do

    let(:params) { {'comment' => {'user_id' => '4', 'content' => 'content'}} }

    context 'on success' do

      before :each do
        Comment.any_instance.stub(:save).and_return(true)
      end

      it 'should redirect to pin_board_path' do
        post :create, params
        response.should redirect_to pin_boards_path
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        Comment.should_receive(:new).with(params['comment']).and_return(comment)
        comment.should_receive(:save).and_return(true)
        post :create, params
        assigns(:comment).should be comment
      end

      it 'should assign flash notice' do
        post :create, params
        flash[:notice].should eq t('model.messages.created', model: Comment.model_name.human)
      end
    end

    context 'on failure' do

      before :each do
        Comment.any_instance.stub(:save).and_return(false)
      end

      it 'should return http success' do
        post :create, params
        response.should be_success
      end

      it 'should render new' do
        post :create, params
        response.should render_template :new
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        Comment.should_receive(:new).with(params['comment']).and_return(comment)
        comment.should_receive(:save).and_return(false)
        post :create, params
        assigns(:comment).should be comment
      end
    end
  end
end