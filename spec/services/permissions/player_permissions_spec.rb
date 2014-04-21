describe PlayerPermissions do

  let(:current_user) { create(:user) }
  subject { PermissionService.new(current_user) }

  describe '#actions' do
    it 'should exactly allow controllers' do

      should exactly_allow_actions(
                 ['devise/sessions', [:new, :create, :destroy]],
                 ['adapted_devise/registrations', [:edit, :update]],
                 [:award_ceremonies, [:show]],
                 [:champion_tips, [:edit, :update]],
                 [:comments, [:new, :create, :edit, :update]],
                 [:match_tips, [:show]],
                 [:pin_boards, [:show]],
                 [:profiles, [:show]],
                 [:rankings, [:show]],
                 [:roots, [:show]],
                 [:tips, [:edit_multiple, :update_multiple]],
                 [:user_tips, [:show]]
             )
    end
  end

  describe '#attributes' do

    it 'should exactly allow attributes' do

      should exactly_allow_attributes(
                 [:user, [:email, :nickname, :first_name, :last_name, :current_password, :password, :password_confirmation, :remember_me]],
                 [:tips, [:score_team_1, :score_team_2]],
                 [:champion_tip, [:team_id]],
                 [:comment, [:user_id, :content]]
             )
    end

  end

  describe '#filters' do

    it 'should exactly have filters for' do
      should exactly_have_filters_for(
          [:comments, [:create, :update]]
             )
    end

    context 'comments#create' do

      it 'should be allowed when params are not given' do
        should pass_filters(:comments, :create)
      end

      it 'should be allowed when it has params :comment' do
        should pass_filters(:comments, :create, params: { comment: {}})
      end

      it 'should be allowed when it has params :comment :user_id equals current_user id' do
        should pass_filters(:comments, :create, params: {comment: {user_id: current_user.id.to_s}})
      end

      it 'should not be allowed when current_user and params[:comment][:user_id] are note equal' do
        should_not pass_filters(:comments, :create, params: {comment: {user_id: ((current_user.id + 1).to_s)}})
      end
    end

    context 'comments#update' do

      it 'should be allowed when params are not given' do
        should pass_filters(:comments, :update)
      end

      it 'should be allowed when it has params :comment' do
        should pass_filters(:comments, :update, params: { comment: {}})
      end

      it 'should be allowed when it has params :comment :user_id equals current_user id' do
        should pass_filters(:comments, :update, params: {comment: {user_id: current_user.id.to_s}})
      end

      it 'should not be allowed when current_user and params[:comment][:user_id] are note equal' do
        should_not pass_filters(:comments, :update, params: {comment: {user_id: ((current_user.id + 1).to_s)}})
      end
    end
  end
end