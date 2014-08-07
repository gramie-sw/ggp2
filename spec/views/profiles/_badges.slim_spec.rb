describe 'profiles/_badges.slim', :type => :view do

  let(:presenter) { double('Presenter') }

  let(:badges) do
    [BadgeRepository.badges_sorted.first]
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
    allow(presenter).to receive(:badges).and_return(badges)
  end

  context 'when Badges are present' do

    it 'should be displayed' do
      render partial_options
      expect(rendered).to have_css 'div.badges-box'
    end

    it 'should not display user not yet awarded message' do
      render partial_options
      expect(rendered).not_to have_css 'div', text: t('badges.user_not_yet_awarded')
    end
  end

  context 'when no Badges are present' do

    let(:badges) { [] }

    it 'should display user not yet awarded message' do
      render partial_options
      expect(rendered).to have_css 'div', text: t('badges.user_not_yet_awarded')
    end
  end
end