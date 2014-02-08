describe User do

  it 'should have valid factory' do
    create(:user).should be_valid
  end

  describe 'player?' do

    context 'if user is not an admin' do

      it 'should return true' do
          build(:user).should be_player
      end
    end

    context 'if user is an admin' do

      it 'should return false' do
          build(:admin).should_not be_player
      end
    end
  end

end
