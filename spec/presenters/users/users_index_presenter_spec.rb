describe UsersIndexPresenter do

  users = :users

  subject { UsersIndexPresenter.new(users) }

  it { expect(subject.users).to be :users }

  it 'returns true if type is admin, otherwhise false' do
    expect(subject.showing_admins?).to be false
    subject = UsersIndexPresenter.new(users, User::TYPES[:player])
    expect(subject.showing_admins?).to be false
    subject = UsersIndexPresenter.new(users, User::TYPES[:admin])
    expect(subject.showing_admins?).to be true
  end
end