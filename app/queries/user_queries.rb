class UserQueries

  class << self

    def all_players
      User.where(admin: false)
    end

    def all_for_ranking(page: nil, per_page: nil)
      self.all_players.page(page).per(per_page).includes(champion_tip: :team)
    end
  end
end