# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == 'development'

  require 'forgery'
  require 'factory_girl'

  FactoryGirl.find_definitions

  #---------team creation---------
  (1..32).each do
    FactoryGirl.create(:team)
  end


#(1..2).each do
#  FactoryGirl.create(:game)
#end
end
