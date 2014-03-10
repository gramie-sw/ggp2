FactoryGirl.define do

  factory :tip do
    association :user
    association :match, date: 2.days.from_now
    score_team_1 { Forgery::Basic.number(at_least: 0, at_most: 7) }
    score_team_2 { Forgery::Basic.number(at_least: 0, at_most: 7) }
    result {0}
  end
end