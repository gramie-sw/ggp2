describe CommentsController, :type => :controller do

  let(:user) { create(:player) }

  before :each do
    sign_in user
  end

  describe '#new' do

    it 'should return http success' do
      get :new
      expect(response).to be_success
    end

    it 'should render template new' do
      get :new
      expect(response).to render_template :new
    end

    it 'should assign correctly instantiated Comment' do
      expect(Comment).to receive(:new).with(user_id: user.id).and_return(:new_comment)
      get :new
      expect(assigns(:comment)).to eq :new_comment
    end
  end

  describe '#create' do

    let(:params) { {comment: {'user_id' => user.id.to_s, 'content' => 'content'}} }

    context 'on success' do

      before :each do
        allow_any_instance_of(Comment).to receive(:save).and_return(true)
      end

      it 'should redirect to pin_board_path' do
        post :create, params
        expect(response).to redirect_to pin_boards_path
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        expect(Comment).to receive(:new).with(params[:comment]).and_return(comment)
        expect(comment).to receive(:save).and_return(true)
        post :create, params
        expect(assigns(:comment)).to be comment
      end

      it 'should run uc UpdateUserBadges with given group (:comment)' do
        expect_any_instance_of(Comment).to receive(:save).with(no_args).and_return(true)
        expect_any_instance_of(UpdateUserBadges).to receive(:run)
        post :create, params
      end

      it 'should assign flash notice' do
        post :create, params
        expect(flash[:notice]).to eq t('model.messages.created', model: Comment.model_name.human)
      end
    end

    context 'on failure' do

      before :each do
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
      end

      it 'should return http success' do
        post :create, params
        expect(response).to be_success
      end

      it 'should render new' do
        post :create, params
        expect(response).to render_template :new
      end

      it 'should assign comment and save it' do
        comment = double('Comment')
        expect(Comment).to receive(:new).with(params[:comment]).and_return(comment)
        expect(comment).to receive(:save).and_return(false)
        post :create, params
        expect(assigns(:comment)).to be comment
      end
    end
  end

  describe '#edit' do

    let(:comment) { create(:comment, user: user) }
    let(:params) { {id: comment.to_param} }

    before :each do
      allow(Comment).to receive(:find).and_return(comment)
    end

    it 'should return http success' do
      get :edit, params
      expect(response).to be_success
    end

    it 'should render edit' do
      get :edit, params
      expect(response).to render_template :edit
    end

    it 'should assign comment of given id' do
      expect(Comment).to receive(:find).with(params[:id]).and_return(comment)
      get :edit, params
      expect(assigns(:comment)).to be comment
    end
  end
end