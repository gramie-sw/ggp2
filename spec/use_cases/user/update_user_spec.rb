describe 'UpdateUser' do

  let(:user_1) { create(:user) }
  let(:current_user) { user_1 }
  let(:new_attributes) do
    {
        nickname: current_user.nickname + '_new'
    }
  end
  let(:callback) { double('Callback') }
  subject { UpdateUser.new(current_user: current_user, user_id: user_1.to_param, attributes: new_attributes) }

  describe '#run_with_callback' do

    context 'on success' do

      it 'should update user and call callback#update_succeeded' do
        expect(callback).to receive(:update_succeeded).with(user_1)
        subject.run_with_callback(callback)

        user_1.reload
        expect(user_1.nickname).to eq new_attributes[:nickname]
      end
    end

    context 'on failure' do

      let(:new_attributes) { {nickname: nil} }

      it 'should not update user and call callback#update_failed' do
        expect(callback).to receive(:update_failed).with(user_1)
        subject.run_with_callback(callback)

        user_1.reload
        expect(user_1.nickname).not_to be_nil
      end
    end

    context 'when current_user is not the updated user' do

      context 'when current user is not admin' do

        let(:current_user) { create(:user) }

        it 'should raise Ggp2::AuthorizationFailedError' do
          expect { subject.run_with_callback(callback) }.to raise_error Ggp2::AuthorizationFailedError
        end
      end

      context 'when current_user is admin' do

        let(:current_user) { create(:admin) }

        it 'should not raise any error' do
          callback.as_null_object
          expect { subject.run_with_callback(callback) }.not_to raise_error
        end
      end
    end
  end
end