FactoryGirl.define do

  factory :ranking_item do
    association :match
    association :user
  end
end