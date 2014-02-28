# Extended object must provide following methods:
#   - score_team_1
#   - score_team_2
#
module ResultPresentable

  def result
    if score_present?
      "#{score_team_1} : #{score_team_2}"
    else
      '- : -'
    end
  end

  def only_result_present_status
    false
  end

  private

  def score_present?
    score_team_1.present? && score_team_2.present?
  end
end