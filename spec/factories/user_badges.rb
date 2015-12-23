FactoryGirl.define do

  factory :user_badge do
    association :user
    badge_group_identifier { 'tip_badge#correct' }
    badge_identifier { badge_group_identifier + %w[bronze silver gold platinum].sample }
  end
end