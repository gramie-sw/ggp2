describe BadgesShowPresenter do

  it { is_expected.to respond_to(:groups=, :groups)}
  it { is_expected.to respond_to(:grouped_badges=, :grouped_badges)}
end