module UserQueries

  class << self

    def all_by_type_ordered(type: nil, order: nil, page: nil, per_page: nil)
      User.where(admin: type == User::TYPES[:admin]).order(order).page(page).per(per_page)
    end

    def all_for_ranking_view(page: nil, per_page: nil)
      User.where(admin: false).includes(champion_tip: :team).page(page).per(per_page)
    end

    def player_count
      User.where(admin: false).count
    end
  end
end