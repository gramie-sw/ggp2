FactoryGirl.define do

  factory :match do
    sequence(:position) { |n| n }
    association :aggregate
    association :team_1, factory: :team
    association :team_2, factory: :team
    score_team_1 { Forgery::Basic.number(at_least: 0, at_most: 7) }
    score_team_2 { Forgery::Basic.number(at_least: 0, at_most: 7) }
    sequence(:placeholder_team_1) { |n| "Placeholder #{n}"}
    sequence(:placeholder_team_2) { |n| "Placeholder #{n + 1}"}
    association :venue
    date { Time.parse('2012.06.08 18:00') }
  end
end