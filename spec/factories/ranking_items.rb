FactoryGirl.define do

  factory :ranking_item do
    association :match
    association :user
    sequence(:position) { |n| n }
    correct_tips_count { Forgery::Basic.number(at_least: 0, at_most: 20) }
    correct_tendency_tips_only_count { Forgery::Basic.number(at_least: 0, at_most: 20) }
  end
end