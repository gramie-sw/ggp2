shared_examples_for 'ShowUsersPresentable' do

  it { is_expected.to respond_to(:users=, :users) }
  it { is_expected.to respond_to(:admin=, :admin, :admin?)}
end