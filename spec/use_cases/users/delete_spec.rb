describe Users::Delete do

  let(:users) do
    [
        create(:user),
        create(:user)
    ]
  end

  let(:user_to_delete) { users.first }

  subject { Users::Delete }

  describe '#run' do

    it 'should delete and return user with given user_id' do
      expect(subject.run(id: user_to_delete.id)).to eq users.first

      expect(User.count).to eq 1
      expect(User.first).to eq users.second
    end
  end
end