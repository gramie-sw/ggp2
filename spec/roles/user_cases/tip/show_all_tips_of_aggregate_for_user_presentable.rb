shared_examples_for 'ShowAllTipsOfAggregateForUserPresentable' do

  it { should respond_to(:current_aggregate=) }
  it { should respond_to(:tips=) }
end