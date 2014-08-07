shared_examples_for 'ShowUserPresentable' do

  it { is_expected.to respond_to(:user=) }
end