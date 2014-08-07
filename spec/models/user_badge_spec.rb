describe UserBadge, :type => :model do

  it 'should have valid factory' do
    expect(build(:user_badge)).to be_valid
  end

  it 'should be included with UserBadgeRepository' do
    expect(UserBadge.included_modules).to include(UserBadgeRepository)
  end
end
