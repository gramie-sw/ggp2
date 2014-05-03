class CommentConsecutiveCreatedBadge < Badge

  attr_accessor :count

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    joined_user_ids = Comment.user_ids_ordered_by_creation_desc.join

    Comment.user_ids_grouped.select do |user_id|
      user_id if joined_user_ids.include?(user_id.to_s * count)
    end
  end

  def identifier
    "#{self.class.name.underscore}_#{count}".to_sym
  end
end