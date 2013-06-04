FactoryGirl.define do

  factory :aggregate do
    sequence(:position) { |n| n }
    name { Forgery::LoremIpsum.words(1)}
  end

  factory :aggregate_with_parent, parent: :aggregate do
    position 2
    name 'second aggregate'
    parent { create(:aggregate) }
  end
end