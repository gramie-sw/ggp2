describe AdminMainNavbarPresenter do

  include Rails.application.routes.url_helpers

  subject { AdminMainNavbarPresenter.new(params: params) }

  let(:params) { {controller: 'controller'} }

  describe '#nav_links' do

    it 'returns NavLinks' do
      nav_links = subject.nav_links
      expect(nav_links.count).to be 5

      expect(nav_links[0].label).to eq t('general.match_schedule')
      expect(nav_links[0].url).to eq match_schedules_path
      expect(nav_links[0].is_active_for).to eq({controller: :match_schedules})
      expect(nav_links[0].params).to be params

      expect(nav_links[1].label).to eq t('general.settings')
      expect(nav_links[1].url).to eq teams_path
      expect(nav_links[1].is_active_for).to eq({controller: [:teams, :tournament_settings]})
      expect(nav_links[1].params).to be params

      expect(nav_links[2].label).to eq t('general.pin_board')
      expect(nav_links[2].url).to eq pin_boards_path
      expect(nav_links[2].is_active_for).to eq({controller: :pin_boards})
      expect(nav_links[2].params).to be params

      expect(nav_links[3].label).to eq User.model_name.human_plural
      expect(nav_links[3].url).to eq users_path(type: User::TYPES[:player])
      expect(nav_links[3].is_active_for).to eq({controller: :users})
      expect(nav_links[3].params).to be params

      expect(nav_links[4].label).to eq t('general.profile.one')
      expect(nav_links[4].url).to eq edit_user_registration_path
      expect(nav_links[4].is_active_for).to eq({controller: :profiles})
      expect(nav_links[4].params).to be params
    end
  end
end