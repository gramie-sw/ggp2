FactoryGirl.define do

  factory :ranking_item do
    association :match
    association :user
    sequence(:position) {|n| n }
  end
end