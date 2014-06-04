describe 'profiles/_badges.slim' do

  let(:presenter) { double('Presenter') }

  let(:user_badges) do
    [UserBadge.new]
  end

  let(:partial_options) do
    {
        partial: 'profiles/badges',
        formats: %w[html],
        handlers: %w[slim],
        locals: {
            presenter: presenter,
        }
    }
  end

  before :each do
    allow(presenter).to receive(:user_badges).and_return(user_badges)
  end

  context 'when UserBadges are present' do

    it 'should be displayed' do
      render partial_options
      rendered.should have_css 'div.badges-box'
    end

    it 'should not display user not yet awarded message' do
      render partial_options
      rendered.should_not have_css 'div', text: t('badges.user_not_yet_awarded')
    end
  end

  context 'when no UserBadges are present' do

    let(:user_badges) { [] }

    it 'should display user not yet awarded message' do
      render partial_options
      rendered.should have_css 'div', text: t('badges.user_not_yet_awarded')
    end
  end
end