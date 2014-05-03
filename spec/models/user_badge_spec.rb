describe UserBadge do

  it 'should have valid factory' do
    build(:user_badge).should be_valid
  end

  it 'should be included with UserBadgeRepository' do
    expect(UserBadge.included_modules).to include(UserBadgeRepository)
  end
end
