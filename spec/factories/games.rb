FactoryGirl.define do

  factory :game do
    sequence(:game_number) { |n| n }
    association :aggregate
    association :team_1, factory: :team
    association :team_2, factory: :team
    placeholder_team_1 'placeholder_team_1'
    placeholder_team_2 'placeholder_team_2'
    date { Time.parse('2012.06.08 18:00') }
  end
end