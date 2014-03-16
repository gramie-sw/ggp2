describe UserTipsController do

  let(:player) { create(:player) }

  before :each do
    sign_in player
  end

  describe '#show' do

    it 'should return http success' do
      get :show, id: player.to_param
      response.should be_success
    end

    it 'should render template show' do
      get :show, id: player.to_param
      response.should render_template :show
    end

    context 'if given user_id belongs to current_user' do
      #TODO refactor to only one test

      it 'should assign UserTipsShowPresenter where user_is_current_user equals true' do
        User.should_receive(:find_player).with(player.to_param).and_return(player)

        UserTipsShowPresenter.
            should_receive(:new).
            with(user: player, tournament: kind_of(Tournament), user_is_current_user: true).
            and_call_original
        get :show, id: player.to_param
      end
    end

    context 'if given user_id belongs not to current_user' do

      it 'should assign UserTipsShowPresenter  where user_is_current_user equals false' do
        other_player = create(:player)
        User.should_receive(:find_player).with(other_player.to_param).and_return(other_player)
        UserTipsShowPresenter.
            should_receive(:new).
            with(user: other_player, tournament: kind_of(Tournament), user_is_current_user: false).
            and_call_original
        get :show, id: other_player.to_param
      end
    end
  end
end
