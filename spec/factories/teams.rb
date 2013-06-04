FactoryGirl.define do

  factory :team do
    name { Country.countries.sample[0] }
    abbreviation { Country.find_country_by_name(name).alpha3 }
  end
end