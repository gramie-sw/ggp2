describe UserMainNavbarPresenter do

  include Rails.application.routes.url_helpers

  subject { UserMainNavbarPresenter.new(params: params, current_user: current_user, tournament: tournament) }

  let(:params) { {controller: 'controller'} }
  let(:current_user) { User.new(id: 86) }
  let(:tournament) { instance_double('Tournament') }

  describe '#nav_links' do

    it 'returns NavLinks without award_ceremony if tournament is not finished' do
      expect(tournament).to receive(:finished?).and_return(false)

      nav_links = subject.nav_links
      expect(nav_links.count).to be 4

      expect(nav_links[0].label).to eq Tip.model_name.human_plural
      expect(nav_links[0].url).to eq user_tip_path(current_user)
      expect(nav_links[0].is_active_for).to eq({controller: [:user_tips, :match_tips]})
      expect(nav_links[0].params).to be params

      expect(nav_links[1].label).to eq t('general.ranking')
      expect(nav_links[1].url).to eq rankings_path
      expect(nav_links[1].is_active_for).to eq({controller: :rankings})
      expect(nav_links[1].params).to be params

      expect(nav_links[2].label).to eq t('general.pin_board')
      expect(nav_links[2].url).to eq pin_boards_path
      expect(nav_links[2].is_active_for).to eq({controller: [:pin_boards, :comments]})
      expect(nav_links[2].params).to be params

      expect(nav_links[3].label).to eq t('general.profile.one')
      expect(nav_links[3].url).to eq profile_path(current_user)
      expect(nav_links[3].is_active_for).to eq({controller: [:profiles, 'adapted_devise/registrations']})
      expect(nav_links[3].params).to be params
    end

    it 'returns NavLinks with award_ceremony if tournament is finished' do
      expect(tournament).to receive(:finished?).and_return(true)

      nav_links = subject.nav_links
      expect(nav_links.count).to be 5

      expect(nav_links[0].label).to eq t('general.award_ceremony')
      expect(nav_links[0].url).to eq award_ceremonies_path
      expect(nav_links[0].is_active_for).to eq({controller: :award_ceremonies})
      expect(nav_links[0].params).to be params
    end
  end
end