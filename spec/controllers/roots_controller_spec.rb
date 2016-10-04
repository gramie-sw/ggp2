describe RootsController do

  describe '#show' do

    context 'current_user is admin' do

      let(:admin) { create(:admin) }

      before :each do
        sign_in admin
      end

      it 'should redirect to match_schedule_path' do
        get :show
        expect(response).to redirect_to match_schedules_path
      end
    end

    context 'current_user is player' do

      let(:player) { create(:player) }

      before :each do
        sign_in player
      end

      context 'tournament is finished' do

        it 'should redirect to AwardCeremoniesController#show' do

          allow_any_instance_of(Tournament).to receive(:finished?).and_return(true)
          get :show
          expect(response).to redirect_to award_ceremonies_path
        end
      end

      context 'tournament is not finished' do

        it 'should redirect to UserTipsController#show' do

          allow_any_instance_of(Tournament).to receive(:finished?).and_return(false)
          get :show
          expect(response).to redirect_to user_tip_path(player)
        end
      end
    end
  end
end