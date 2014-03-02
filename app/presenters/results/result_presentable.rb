# Extended object must provide following methods:
#   - score_team_1
#   - score_team_2
#
# Extended objects can override #hide_existing_result? to control
# whether an existing result is formatted as hidden?
module ResultPresentable

  def result
    if result_present?
      hide_existing_result? ? '* : *' : "#{score_team_1} : #{score_team_2}"
    else
      "- : -"
    end
  end

  def hide_existing_result?
    false
  end

  private

  def result_present?
    score_team_1.present? && score_team_2.present?
  end
end