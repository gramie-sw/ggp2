FactoryGirl.define do

  factory :venue do
    city { Forgery(:address).city }
    stadium { "#{city} #{%w[Arena Hippodrome Park Stadium].sample}"}
    capacity { Forgery::Basic.number(at_least: 40000, at_most: 80000) }
  end
end