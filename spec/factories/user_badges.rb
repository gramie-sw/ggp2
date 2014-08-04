FactoryGirl.define do

  factory :user_badge do
    association :user
    badge_identifier { BadgeRepository.badges_sorted.sample.identifier }
  end
end