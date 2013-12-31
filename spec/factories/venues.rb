FactoryGirl.define do

  factory :venue do
    city { Forgery(:address).city }
    stadium { "#{city} #{%w[Arena Hippodrome Park Stadium].sample}"}
  end
end