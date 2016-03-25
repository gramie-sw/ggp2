module UserQueries

  class << self

    def players_ordered_by_nickname_asc_for_a_match_paginated(match_id:, page:, per_page: Ggp2.config.user_page_count)
      User.players.includes(:tips).where('tips.match_id = ?', match_id).order(nickname: :asc).
          references(:tips).page(page).per(per_page)
    end

    def paginated_by_type(type: nil, order: nil, page: nil, per_page: nil)
      User.where(admin: type == User::TYPES[:admin]).order(order).page(page).per(per_page)
    end

    def paginated_for_ranking_view(page: nil, per_page: nil)
      User.where(admin: false).includes(champion_tip: :team).page(page).per(per_page)
    end

    def player_count
      User.where(admin: false).count
    end

    def all_player_ids
      User.where(admin: false).pluck(:id)
    end
  end
end