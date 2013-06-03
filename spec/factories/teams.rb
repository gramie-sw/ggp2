FactoryGirl.define do

  factory :team do
    name { Forgery(:address).country }
    abbreviation { Country.find_country_by_name(name).alpha3 }
  end
end