FactoryBot.define do

  factory :property do
    key { Forgery::Basic.text(at_least: 5, at_most: 20)}
    value { Forgery::Basic.text(at_least: 10, at_most: 30)}
  end
end