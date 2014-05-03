class CommentCreatedBadge < Badge

  attr_accessor :count

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    Comment.user_ids_with_at_least_comments(count)
  end

  def identifier
    "#{self.class.name.underscore}_#{count}".to_sym
  end
end