FactoryBot.define do

  factory :match do
    sequence(:position) { |n| n }
    association :aggregate
    association :team_1, factory: :team
    association :team_2, factory: :team
    sequence(:placeholder_team_1) { |n| "Placeholder #{n}"}
    sequence(:placeholder_team_2) { |n| "Placeholder #{n + 1}"}
    date { 2.day.from_now }
  end
end