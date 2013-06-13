FactoryGirl.define do

  factory :team do
    sequence :name do |n|
      Country.countries[n][0]
    end
    abbreviation { Country.find_country_by_name(name).alpha3 }
  end
end