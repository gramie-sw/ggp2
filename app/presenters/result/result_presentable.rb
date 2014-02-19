# Extended object must provide following methods:
#   - score_team_1
#   - score_team_2
#
module ResultPresentable

  def result
    if score_team_1.present? && score_team_2.present?
      "#{score_team_1} : #{score_team_2}"
    else
      '- : -'
    end
  end

end