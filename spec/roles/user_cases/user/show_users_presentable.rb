shared_examples_for 'ShowUsersPresentable' do

  it { should respond_to(:users=, :users) }
  it { should respond_to(:admin=, :admin, :admin?)}
end