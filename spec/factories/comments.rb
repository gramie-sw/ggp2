FactoryBot.define do

  factory :comment do
    association :user
    content { Forgery(:lorem_ipsum).sentences(4, random: true) }
  end
end