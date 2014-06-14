class CommentsPresenter < DelegateClass(Comment)

  attr_reader :is_for_current_user, :editable, :destroyable
  attr_reader :is_for_current_user
  alias :is_for_current_user? :is_for_current_user
  alias :editable? :editable
  alias :destroyable? :destroyable

  def initialize(comment:, is_for_current_user:, is_admin:)
    super(comment)
    @editable = is_for_current_user
    @destroyable = is_admin
    @is_for_current_user = is_for_current_user
  end

  def is_for_current_user

  end
end