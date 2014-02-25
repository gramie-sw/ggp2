FactoryGirl.define do

  factory :match_result do
    match_id { create(:match).id }
    score_team_1 { Forgery::Basic.number(at_least: 0, at_most: 7) }
    score_team_2 { Forgery::Basic.number(at_least: 0, at_most: 7) }
  end
end