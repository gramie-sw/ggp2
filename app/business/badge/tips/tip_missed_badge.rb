class TipMissedBadge < Badge

  attr_accessor :count

  def initialize attributes={}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    Tip.user_ids_with_at_least_missed_tips(count: count)
  end
end