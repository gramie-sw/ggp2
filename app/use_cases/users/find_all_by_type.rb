module Users
  class FindAllByType < UseCase

    attribute :type, String, default: User::TYPES[:player]
    attribute :page, Integer

    def run
      UserQueries.all_by_type_ordered(type: type, order: :nickname, page: page, per_page: per_page)
    end

    private

    def per_page
      Ggp2.config.user_page_count
    end
  end
end