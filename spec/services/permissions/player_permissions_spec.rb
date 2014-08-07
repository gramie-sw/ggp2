describe PlayerPermissions do

  let(:current_user) { create(:user) }
  subject { PermissionService.new(current_user) }

  describe '#actions' do
    it 'should exactly allow controllers' do

      is_expected.to exactly_allow_actions(
                 ['devise/sessions', [:new, :create, :destroy]],
                 ['adapted_devise/registrations', [:edit, :update]],
                 [:award_ceremonies, [:show]],
                 [:badges, [:show]],
                 [:champion_tips, [:edit, :update]],
                 [:comments, [:new, :create, :edit, :update]],
                 [:match_tips, [:show]],
                 [:pin_boards, [:show]],
                 [:profiles, [:show]],
                 [:rankings, [:show]],
                 [:roots, [:show]],
                 [:tips, [:edit_multiple, :update_multiple]],
                 [:users, :update],
                 [:user_tips, [:show]]
             )
    end
  end


  describe '#attributes' do

    it 'should exactly allow attributes' do

      is_expected.to exactly_allow_attributes(
                 [:user, [:email, :nickname, :first_name, :last_name, :current_password, :password, :password_confirmation, :remember_me, :match_sort]],
                 [:tips, [:score_team_1, :score_team_2]],
                 [:champion_tip, [:team_id]],
                 [:comment, [:user_id, :content]]
             )
    end

  end

  describe '#filters' do

    it 'should exactly have filters for' do
      is_expected.to exactly_have_filters_for(
                 [:comments, [:create, :update, :edit]],
                 [:tips, [:edit_multiple, :update_multiple]],
                 [:champion_tips, [:edit, :update]]
             )
    end

    context 'comments#create' do

      context 'if user_id of comment belongs to to current_user' do

        it 'should be allowed' do
          is_expected.to pass_filters(:comments, :create, params: {comment: {user_id: current_user.to_param}})
        end
      end

      context 'if user_id of comment does not belong to to current_user' do

        it 'should not be allowed' do
          is_expected.not_to pass_filters(:comments, :create, params: {comment: {user_id: (current_user.id+1).to_s}})
        end
      end
    end
  end

  context 'comments#edit' do

    context 'if comment belongs to to current_user' do

      it 'should be allowed' do
        is_expected.to pass_filters(:comments, :edit, resource: Comment.new(user_id: current_user.id))
      end
    end

    context 'if comment belongs to to current_user' do

      it 'should not be allowed' do
        is_expected.not_to pass_filters(:comments, :edit, resource: Comment.new(user_id: current_user.id + 1))
      end
    end
  end

  context 'comments#update' do

    context 'if comment belongs to to current_user' do

      it 'should be allowed' do
        is_expected.to pass_filters(:comments, :update, resource: Comment.new(user_id: current_user.id))
      end
    end

    context 'if comment belongs to to current_user' do

      it 'should not be allowed' do
        is_expected.not_to pass_filters(:comments, :update, resource: Comment.new(user_id: current_user.id + 1))
      end
    end
  end

  context 'tips#edit_multiple' do

    let(:tips) do
      [
          Tip.new(user_id: current_user.id),
          Tip.new(user_id: current_user.id)
      ]
    end

    before :each do
      expect(Tip).to receive(:where).with(id: [1, 2]).and_return(tips)
    end

    context 'if all tips belong to current_user' do

      it 'should be allowed' do
        is_expected.to pass_filters(:tips, :edit_multiple, params: {tip_ids: [1, 2]})
      end
    end

    context 'if at lest one tip does not belong to current_user' do

      it 'should not be allowed' do
        tips.first.user_id = current_user.id + 1
        is_expected.not_to pass_filters(:tips, :edit_multiple, params: {tip_ids: [1, 2]})
      end
    end
  end

  context 'tips#update_multiple' do

    let(:tips) do
      [
          Tip.new(user_id: current_user.id),
          Tip.new(user_id: current_user.id)
      ]
    end

    before :each do
      expect(Tip).to receive(:where).with(id: ['1', '2']).and_return(tips)
    end

    context 'if all tips belong to current_user' do

      it 'should be allowed' do
        is_expected.to pass_filters(:tips, :update_multiple, params: {tips: {'1' => {}, '2' => {}}})
      end
    end

    context 'if at lest one tip does not belong to current_user' do

      it 'should not be allowed' do
        tips.first.user_id = current_user.id + 1
        is_expected.not_to pass_filters(:tips, :update_multiple, params: {tips: {'1' => {}, '2' => {}}})
      end
    end
  end

  context 'champion_tips#edit' do

    context 'if champion_tip belongs to to current_user' do

      it 'should be allowed' do
        is_expected.to pass_filters(:champion_tips, :edit, resource: ChampionTip.new(user_id: current_user.id))
      end
    end

    context 'if champion_tip belongs to to current_user' do

      it 'should not be allowed' do
        is_expected.not_to pass_filters(:champion_tips, :edit, resource: ChampionTip.new(user_id: current_user.id + 1))
      end
    end
  end

  context 'champion_tips#update' do

    context 'if champion_tip belongs to to current_user and tournament is not started' do

      it 'should be allowed' do
        expect_any_instance_of(Tournament).to receive(:started?).and_return(false)
        is_expected.to pass_filters(:champion_tips, :edit, resource: ChampionTip.new(user_id: current_user.id))
      end
    end

    context 'if champion_tip belongs to to current_user but tournament is started' do

      it 'should not be allowed' do
        expect_any_instance_of(Tournament).to receive(:started?).and_return(true)
        is_expected.not_to pass_filters(:champion_tips, :edit, resource: ChampionTip.new(user_id: current_user.id))
      end
    end

    context 'if champion_tip does not belong to current_user' do

      it 'should not be allowed' do
        is_expected.not_to pass_filters(:champion_tips, :edit, resource: ChampionTip.new(user_id: current_user.id + 1))
      end
    end
  end
end