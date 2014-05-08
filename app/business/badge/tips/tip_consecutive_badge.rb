class TipConsecutiveBadge < Badge

  attr_accessor :result, :count

  def initialize attributes= {}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    Tip.user_ids_with_at_least_result_tips(result: Tip::RESULTS[result.to_sym], count: count).select do |user_id|
      user_id if Tip.ordered_results_by_user_id(user_id).join.include?(Tip::RESULTS[result.to_sym].to_s * count)
    end
  end

  def identifier
    "#{self.class.name.underscore}_#{result}_#{count}".to_sym
  end
end