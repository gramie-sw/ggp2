describe UserTipsShowPresenter do

  let(:user) { create(:player) }
  subject { UserTipsShowPresenter.new(user_id: user.id) }

  #describe '#matches' do
  #
  #  it 'should return all matches ordered_by_position' do
  #    Match.should_receive(:order_by_position)
  #    subject.matches
  #  end
  #end
end