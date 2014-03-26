class CommentsPresenter < DelegateClass(Comment)

  attr_reader :is_for_current_user
  alias :is_for_current_user? :is_for_current_user

  def initialize(comment:, is_for_current_user:)
    super(comment)
    @is_for_current_user = is_for_current_user
  end

  def is_for_current_user

  end
end