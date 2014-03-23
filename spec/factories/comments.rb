FactoryGirl.define do

  factory :comment do
    association :user
    content { Forgery(:basic).password(:at_least => 100, :at_most => 500)}
  end
end