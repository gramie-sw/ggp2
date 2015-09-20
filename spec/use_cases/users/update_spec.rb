describe 'Users::Update' do

  let(:user_1) { create(:user) }
  let(:current_user) { user_1 }
  let(:new_attributes) { {nickname: current_user.nickname + '_new'} }
  subject { Users::Update }

  describe '#run' do

    context 'on success' do

      it 'returns updated user' do
        actual_user = subject.run(current_user: current_user, user_id: user_1.id, user_attributes: new_attributes)

        expect(actual_user.errors).to be_empty
        expect(actual_user).not_to be_changed
        expect(actual_user.nickname).to eq new_attributes[:nickname]
      end
    end

    context 'on failure' do

      let(:new_attributes) { {nickname: nil} }

      it 'returns updated user with errors' do
        actual_user = subject.run(current_user: current_user, user_id: user_1.id, user_attributes: new_attributes)

        expect(actual_user.errors).not_to be_empty
        expect(actual_user).to be_changed
        expect(actual_user.nickname).to eq new_attributes[:nickname]
      end
    end

    context 'when current_user is not the updated user' do

      context 'when current user is not admin' do

        let(:current_user) { create(:user) }

        it 'raises Ggp2::AuthorizationFailedError' do
          expect { subject.run(current_user: current_user, user_id: user_1.id, user_attributes: new_attributes) }.
              to raise_error Ggp2::AuthorizationFailedError
        end
      end

      context 'when current_user is admin' do

        let(:current_user) { create(:admin) }

        it 'raises any error' do
          expect { subject.run(current_user: current_user, user_id: user_1.id, user_attributes: new_attributes) }.
              not_to raise_error
        end
      end
    end
  end
end