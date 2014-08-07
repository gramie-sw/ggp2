shared_examples_for 'ShowAllPhasesPresentable' do

  it { is_expected.to respond_to(:phases=) }
end