class TipConsecutiveBadge < Badge

  attr_accessor :result, :count

  def initialize attributes= {}
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def eligible_user_ids
    Tip.user_ids_with_at_least_result_tips(result: Tip::RESULTS[result.to_sym], count: count).select do |user_id|
      user_id if at_least_consecutive_results?(Tip.ordered_results_by_user_id(user_id), Tip::RESULTS[result.to_sym].to_s)
    end
  end

  def identifier
    "#{self.class.name.underscore}_#{result}_#{count}".to_sym
  end

  private

  def at_least_consecutive_results? ordered_user_results, result
    ordered_user_results.map! { |value| value || Tip::MISSED }.join.include?(result * count)
  end
end