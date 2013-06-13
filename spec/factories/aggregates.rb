FactoryGirl.define do

  factory :aggregate do
    sequence(:position) { |n| n }
    name { Forgery::Basic.text(at_least: 5, at_most: 20) }
  end

  factory :aggregate_with_parent, parent: :aggregate do
    position 2
    name { Forgery::Basic.text(at_least: 5, at_most: 20) }
    parent { create(:aggregate) }
  end
end