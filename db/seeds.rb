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
  teams = (1..32).map { FactoryGirl.create(:team) }

  #---------venue creation---------
  venues = []
  venues << FactoryGirl.create(:venue, city: 'Rio de Janeiro', stadium: 'Estádio do Maracanã', capacity: 76935)
  venues << FactoryGirl.create(:venue, city: 'Brasilia', stadium: 'Estádio Nacional Mané Garrincha', capacity: 70042)
  venues << FactoryGirl.create(:venue, city: 'São Paulo', stadium: 'Arena Corinthians', capacity: 68000)
  venues << FactoryGirl.create(:venue, city: 'Fortaleza', stadium: 'Estádio Castelão', capacity: 64846)
  venues << FactoryGirl.create(:venue, city: 'Belo Horizonte', stadium: 'Estádio Mineirão', capacity: 62547)
  venues << FactoryGirl.create(:venue, city: 'Porto Alegre', stadium: 'Estádio Beira-Rio', capacity: 51300)
  venues << FactoryGirl.create(:venue, city: 'Salvador', stadium: 'Arena Fonte Nova', capacity: 56000)
  venues << FactoryGirl.create(:venue, city: 'Recife', stadium: 'Arena Pernambuco', capacity: 46154)
  venues << FactoryGirl.create(:venue, city: 'Cuiabá', stadium: 'Arena Pantanal', capacity: 42968)
  venues << FactoryGirl.create(:venue, city: 'Manaus', stadium: 'Arena Amazônia', capacity: 42374)
  venues << FactoryGirl.create(:venue, city: 'Natal', stadium: 'Arena das Dunas', capacity: 42086)
  venues << FactoryGirl.create(:venue, city: 'Curitiba', stadium: 'Arena da Baixada', capacity: 43981)

  #---------game creation---------
  FactoryGirl.create(:match, position: 1, team_1: teams[0], team_2: teams[1], venue: venues[2], date: Time.utc(2014, 06, 12, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 2, team_1: teams[2], team_2: teams[3], venue: venues[10], date: Time.utc(2014, 06, 13, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 3, team_1: teams[4], team_2: teams[5], venue: venues[6], date: Time.utc(2014, 06, 13, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 4, team_1: teams[6], team_2: teams[7], venue: venues[8], date: Time.utc(2014, 06, 13, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 5, team_1: teams[8], team_2: teams[9], venue: venues[4], date: Time.utc(2014, 06, 14, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 6, team_1: teams[10], team_2: teams[11], venue: venues[7], date: Time.utc(2014, 06, 15, 01, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 7, team_1: teams[12], team_2: teams[13], venue: venues[3], date: Time.utc(2014, 06, 14, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 8, team_1: teams[14], team_2: teams[15], venue: venues[9], date: Time.utc(2014, 06, 14, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 9, team_1: teams[16], team_2: teams[17], venue: venues[1], date: Time.utc(2014, 06, 15, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 10, team_1: teams[18], team_2: teams[19], venue: venues[5], date: Time.utc(2014, 06, 15, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 11, team_1: teams[20], team_2: teams[21], venue: venues[0], date: Time.utc(2014, 06, 15, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 12, team_1: teams[22], team_2: teams[23], venue: venues[11], date: Time.utc(2014, 06, 16, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 13, team_1: teams[24], team_2: teams[25], venue: venues[6], date: Time.utc(2014, 06, 16, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 14, team_1: teams[26], team_2: teams[27], venue: venues[10], date: Time.utc(2014, 06, 16, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 15, team_1: teams[28], team_2: teams[29], venue: venues[4], date: Time.utc(2014, 06, 17, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 16, team_1: teams[30], team_2: teams[31], venue: venues[8], date: Time.utc(2014, 06, 17, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 17, team_1: teams[0], team_2: teams[2], venue: venues[3], date: Time.utc(2014, 06, 17, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 18, team_1: teams[3], team_2: teams[1], venue: venues[9], date: Time.utc(2014, 06, 18, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 19, team_1: teams[4], team_2: teams[6], venue: venues[0], date: Time.utc(2014, 06, 18, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 20, team_1: teams[7], team_2: teams[5], venue: venues[5], date: Time.utc(2014, 06, 18, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 21, team_1: teams[8], team_2: teams[10], venue: venues[1], date: Time.utc(2014, 06, 19, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 22, team_1: teams[11], team_2: teams[9], venue: venues[10], date: Time.utc(2014, 06, 19, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 23, team_1: teams[12], team_2: teams[14], venue: venues[2], date: Time.utc(2014, 06, 19, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 24, team_1: teams[15], team_2: teams[13], venue: venues[7], date: Time.utc(2014, 06, 20, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 25, team_1: teams[16], team_2: teams[18], venue: venues[6], date: Time.utc(2014, 06, 20, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 26, team_1: teams[19], team_2: teams[17], venue: venues[11], date: Time.utc(2014, 06, 20, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 27, team_1: teams[20], team_2: teams[22], venue: venues[4], date: Time.utc(2014, 06, 21, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 28, team_1: teams[23], team_2: teams[21], venue: venues[8], date: Time.utc(2014, 06, 21, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 29, team_1: teams[24], team_2: teams[26], venue: venues[3], date: Time.utc(2014, 06, 21, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 30, team_1: teams[27], team_2: teams[25], venue: venues[9], date: Time.utc(2014, 06, 22, 22, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 31, team_1: teams[28], team_2: teams[30], venue: venues[0], date: Time.utc(2014, 06, 22, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 32, team_1: teams[31], team_2: teams[29], venue: venues[5], date: Time.utc(2014, 06, 22, 19, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 33, team_1: teams[3], team_2: teams[0], venue: venues[1], date: Time.utc(2014, 06, 23, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 34, team_1: teams[1], team_2: teams[2], venue: venues[7], date: Time.utc(2014, 06, 23, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 35, team_1: teams[7], team_2: teams[4], venue: venues[11], date: Time.utc(2014, 06, 23, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 36, team_1: teams[5], team_2: teams[6], venue: venues[2], date: Time.utc(2014, 06, 23, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 37, team_1: teams[11], team_2: teams[8], venue: venues[8], date: Time.utc(2014, 06, 24, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 38, team_1: teams[9], team_2: teams[10], venue: venues[3], date: Time.utc(2014, 06, 24, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 39, team_1: teams[15], team_2: teams[12], venue: venues[10], date: Time.utc(2014, 06, 24, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 40, team_1: teams[13], team_2: teams[14], venue: venues[4], date: Time.utc(2014, 06, 24, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 41, team_1: teams[19], team_2: teams[16], venue: venues[9], date: Time.utc(2014, 06, 25, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 42, team_1: teams[17], team_2: teams[18], venue: venues[0], date: Time.utc(2014, 06, 25, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 43, team_1: teams[23], team_2: teams[20], venue: venues[5], date: Time.utc(2014, 06, 25, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 44, team_1: teams[21], team_2: teams[22], venue: venues[6], date: Time.utc(2014, 06, 25, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 45, team_1: teams[27], team_2: teams[24], venue: venues[7], date: Time.utc(2014, 06, 26, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 46, team_1: teams[25], team_2: teams[26], venue: venues[1], date: Time.utc(2014, 06, 26, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 47, team_1: teams[31], team_2: teams[28], venue: venues[2], date: Time.utc(2014, 06, 26, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 48, team_1: teams[29], team_2: teams[30], venue: venues[11], date: Time.utc(2014, 06, 26, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 49, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group A', placeholder_team_2: 'Runner-up Group B', venue: venues[4], date: Time.utc(2014, 06, 28, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 50, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group C', placeholder_team_2: 'Runner-up Group D', venue: venues[0], date: Time.utc(2014, 06, 28, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 51, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group E', placeholder_team_2: 'Runner-up Group F', venue: venues[1], date: Time.utc(2014, 06, 29, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 52, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group G', placeholder_team_2: 'Runner-up Group H', venue: venues[5], date: Time.utc(2014, 06, 29, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 53, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group B', placeholder_team_2: 'Runner-up Group A', venue: venues[3], date: Time.utc(2014, 06, 30, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 54, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group D', placeholder_team_2: 'Runner-up Group C', venue: venues[7], date: Time.utc(2014, 06, 30, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 55, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group F', placeholder_team_2: 'Runner-up Group E', venue: venues[2], date: Time.utc(2014, 07, 1, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 56, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Group H', placeholder_team_2: 'Runner-up Group G', venue: venues[6], date: Time.utc(2014, 07, 1, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 57, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 49', placeholder_team_2: 'Winner Match 50', venue: venues[3], date: Time.utc(2014, 07, 4, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 58, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 53', placeholder_team_2: 'Winner Match 54', venue: venues[0], date: Time.utc(2014, 07, 4, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 59, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 51', placeholder_team_2: 'Winner Match 52', venue: venues[6], date: Time.utc(2014, 07, 5, 16, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 60, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 55', placeholder_team_2: 'Winner Match 56', venue: venues[1], date: Time.utc(2014, 07, 5, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 61, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 57', placeholder_team_2: 'Winner Match 58', venue: venues[4], date: Time.utc(2014, 07, 8, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 62, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 59', placeholder_team_2: 'Winner Match 60', venue: venues[2], date: Time.utc(2014, 07, 9, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 63, team_1: nil, team_2: nil, placeholder_team_1: 'Loser Match 61', placeholder_team_2: 'Loser Match 62', venue: venues[1], date: Time.utc(2014, 07, 12, 20, 00, 00).iso8601)
  FactoryGirl.create(:match, position: 64, team_1: nil, team_2: nil, placeholder_team_1: 'Winner Match 61', placeholder_team_2: 'Winner Match 62', venue: venues[0], date: Time.utc(2014, 07, 13, 19, 00, 00).iso8601)
end
