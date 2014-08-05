class CommentConsecutiveCreatedBadge < Badge

  attr_accessor :count

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    joined_user_ids = Comment.user_ids_ordered_by_creation_desc.join(',')

    Comment.user_ids_grouped.select do |user_id|
      expected_user_id_sequence = Array.new(count) {user_id}.join(',')
      user_id if joined_user_ids.match(/(^|,)#{expected_user_id_sequence}/)
    end
  end
end