FactoryBot.define do

  factory :aggregate, aliases: [:phase] do
    sequence(:position) { |n| n }
    name { Forgery::Basic.text(at_least: 5, at_most: 20) }

    factory :aggregate_with_parent, aliases: [:group] do
      parent { create(:aggregate) }
    end
  end
end