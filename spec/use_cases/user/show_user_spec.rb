describe ShowUser do

  let(:users) do
    [
        create(:user),
        create(:user)
    ]
  end

  let(:user_to_show) { users.first }

  subject { ShowUser.new(user_to_show.id) }

  describe '#run_with_presentable' do

    let(:presentable) { 'ShowUserPresentable' }

    it 'should set User with given id to presentable' do

      expect(presentable).to receive(:user=) do |actual_user|
        expect(actual_user).to eq users.first
      end

      subject.run_with_presentable(presentable)
    end
  end
end