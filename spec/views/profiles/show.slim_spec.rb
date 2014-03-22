describe 'profiles/show.slim' do

  let(:user) { build(:player, id: 5) }
  let(:is_for_current_user) { true }
  let(:section) { :statistic }
  let(:presenter) do
    ProfilesShowPresenter.new(user: user, tournament: Tournament.new, is_for_current_user: is_for_current_user, section: section)
  end

  before :each do
    assign(:presenter, presenter)
  end

  it 'should render partial for given section' do
    render
    rendered.should have_css('h2', t('profile.section.statistic'))
  end
end