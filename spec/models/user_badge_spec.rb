describe UserBadge, :type => :model do

  it 'has valid factory' do
    expect(build(:user_badge)).to be_valid
  end
end
