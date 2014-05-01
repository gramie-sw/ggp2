FactoryGirl.define do

  factory :user_badge do
    association :user
    badge_identifier do

    end

    factory :user_comment_badge do

    end

    factory :user_tip_badge do

    end
  end
end