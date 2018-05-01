FactoryBot.define do

  factory :champion_tip do
    association :user
    association :team
  end
end