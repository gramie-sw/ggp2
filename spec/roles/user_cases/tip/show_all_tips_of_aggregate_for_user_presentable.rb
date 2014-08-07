shared_examples_for 'ShowAllTipsOfAggregateForUserPresentable' do

  it { is_expected.to respond_to(:current_aggregate=) }
  it { is_expected.to respond_to(:tips=) }
end