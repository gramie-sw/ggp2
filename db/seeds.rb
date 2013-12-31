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
  teams = []
  (1..32).each do
    teams << FactoryGirl.create(:team)
  end

  #---------venue creation---------
  venues = []
  venues << FactoryGirl.create(:venue, city: 'Rio de Janeiro', stadium: 'Estádio do Maracanã')
  venues << FactoryGirl.create(:venue, city: 'Brasilia', stadium: 'Estádio Nacional Mané Garrincha')
  venues << FactoryGirl.create(:venue, city: 'São Paulo', stadium: 'Arena Corinthians')
  venues << FactoryGirl.create(:venue, city: 'Fortaleza', stadium: 'Estádio Castelão')
  venues << FactoryGirl.create(:venue, city: 'Belo Horizonte', stadium: 'Estádio Mineirão')
  venues << FactoryGirl.create(:venue, city: 'Porto Alegre', stadium: 'Estádio Beira-Rio')
  venues << FactoryGirl.create(:venue, city: 'Salvador', stadium: 'Arena Fonte Nova')
  venues << FactoryGirl.create(:venue, city: 'Recife', stadium: 'Arena Pernambuco')
  venues << FactoryGirl.create(:venue, city: 'Cuiabá', stadium: 'Arena Pantanal')
  venues << FactoryGirl.create(:venue, city: 'Manaus', stadium: 'Arena Amazônia')
  venues << FactoryGirl.create(:venue, city: 'Natal', stadium: 'Arena das Dunas')
  venues << FactoryGirl.create(:venue, city: 'Curitiba', stadium: 'Arena da Baixada')

  #---------game creation---------
  FactoryGirl.create(:match, position: 1, team_1: teams[0], team_2: teams[1])
  FactoryGirl.create(:match, position: 2, team_1: teams[2], team_2: teams[3])
  FactoryGirl.create(:match, position: 3, team_1: teams[4], team_2: teams[5])
  FactoryGirl.create(:match, position: 4, team_1: teams[6], team_2: teams[7])
  FactoryGirl.create(:match, position: 5, team_1: teams[8], team_2: teams[9])
  FactoryGirl.create(:match, position: 6, team_1: teams[10], team_2: teams[11])
  FactoryGirl.create(:match, position: 7, team_1: teams[12], team_2: teams[13])
  FactoryGirl.create(:match, position: 8, team_1: teams[14], team_2: teams[15])
  FactoryGirl.create(:match, position: 9, team_1: teams[16], team_2: teams[17])
  FactoryGirl.create(:match, position: 10, team_1: teams[18], team_2: teams[19])
  FactoryGirl.create(:match, position: 11, team_1: teams[20], team_2: teams[21])
  FactoryGirl.create(:match, position: 12, team_1: teams[22], team_2: teams[23])
  FactoryGirl.create(:match, position: 13, team_1: teams[24], team_2: teams[25])
  FactoryGirl.create(:match, position: 14, team_1: teams[26], team_2: teams[27])
  FactoryGirl.create(:match, position: 15, team_1: teams[28], team_2: teams[29])
  FactoryGirl.create(:match, position: 16, team_1: teams[30], team_2: teams[31])
  FactoryGirl.create(:match, position: 17, team_1: teams[0], team_2: teams[2])
  FactoryGirl.create(:match, position: 18, team_1: teams[3], team_2: teams[1])
  FactoryGirl.create(:match, position: 19, team_1: teams[4], team_2: teams[6])
  FactoryGirl.create(:match, position: 20, team_1: teams[7], team_2: teams[5])
  FactoryGirl.create(:match, position: 21, team_1: teams[8], team_2: teams[10])
  FactoryGirl.create(:match, position: 22, team_1: teams[11], team_2: teams[9])
  FactoryGirl.create(:match, position: 23, team_1: teams[12], team_2: teams[14])
  FactoryGirl.create(:match, position: 24, team_1: teams[15], team_2: teams[13])
  FactoryGirl.create(:match, position: 25, team_1: teams[16], team_2: teams[18])
  FactoryGirl.create(:match, position: 26, team_1: teams[19], team_2: teams[17])
  FactoryGirl.create(:match, position: 27, team_1: teams[20], team_2: teams[22])
  FactoryGirl.create(:match, position: 28, team_1: teams[23], team_2: teams[21])
  FactoryGirl.create(:match, position: 29, team_1: teams[24], team_2: teams[26])
  FactoryGirl.create(:match, position: 30, team_1: teams[27], team_2: teams[25])
  FactoryGirl.create(:match, position: 31, team_1: teams[28], team_2: teams[30])
  FactoryGirl.create(:match, position: 32, team_1: teams[31], team_2: teams[29])
  FactoryGirl.create(:match, position: 33, team_1: teams[3], team_2: teams[0])
  FactoryGirl.create(:match, position: 34, team_1: teams[1], team_2: teams[2])
  FactoryGirl.create(:match, position: 35, team_1: teams[7], team_2: teams[4])
  FactoryGirl.create(:match, position: 36, team_1: teams[5], team_2: teams[6])
  FactoryGirl.create(:match, position: 37, team_1: teams[11], team_2: teams[8])
  FactoryGirl.create(:match, position: 38, team_1: teams[9], team_2: teams[10])
  FactoryGirl.create(:match, position: 39, team_1: teams[15], team_2: teams[12])
  FactoryGirl.create(:match, position: 40, team_1: teams[13], team_2: teams[14])
  FactoryGirl.create(:match, position: 41, team_1: teams[19], team_2: teams[16])
  FactoryGirl.create(:match, position: 42, team_1: teams[17], team_2: teams[18])
  FactoryGirl.create(:match, position: 43, team_1: teams[23], team_2: teams[20])
  FactoryGirl.create(:match, position: 44, team_1: teams[21], team_2: teams[22])
  FactoryGirl.create(:match, position: 45, team_1: teams[27], team_2: teams[24])
  FactoryGirl.create(:match, position: 46, team_1: teams[25], team_2: teams[26])
  FactoryGirl.create(:match, position: 47, team_1: teams[31], team_2: teams[28])
  FactoryGirl.create(:match, position: 48, team_1: teams[29], team_2: teams[30])

end
