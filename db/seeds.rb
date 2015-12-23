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
  include FactoryGirl::Syntax::Methods


  puts "#---------user creation---------"
  create(:admin, email: 'admin@mail.de', password: '12345678')
  create(:player, email: 'player@mail.de', password: '12345678')
  (1..60).each { create(:player) }

  puts "#---------team creation---------"
  teams = (1..32).map { create(:team) }

  #-------aggregate creation------

  group_stage = create(:aggregate, position: 1, name: 'Group Stage')
  group_a = create(:aggregate, position: 1, name: 'Group A', parent: group_stage)
  group_b = create(:aggregate, position: 2, name: 'Group B', parent: group_stage)
  group_c = create(:aggregate, position: 3, name: 'Group C', parent: group_stage)
  group_d = create(:aggregate, position: 4, name: 'Group D', parent: group_stage)
  group_e = create(:aggregate, position: 5, name: 'Group E', parent: group_stage)
  group_f = create(:aggregate, position: 6, name: 'Group F', parent: group_stage)
  group_g = create(:aggregate, position: 7, name: 'Group G', parent: group_stage)
  group_h = create(:aggregate, position: 8, name: 'Group H', parent: group_stage)

  round_of_16 = create(:aggregate, position: 2, name: 'Round of 16')
  quarter_finals = create(:aggregate, position: 3, name: 'Quarter Finals')
  semi_finals = create(:aggregate, position: 4, name: 'Semi Finals')
  finals = create(:aggregate, position: 5, name: 'Finals')

  puts "#---------game creation---------"
  create(:match, position: 1, team_1: teams[0], team_2: teams[1], score_team_1: 3, score_team_2: 1, aggregate: group_a, date: Time.utc(2015, 06, 12, 20, 00, 00).iso8601)
  create(:match, position: 2, team_1: teams[2], team_2: teams[3], score_team_1: 1, score_team_2: 0, aggregate: group_a, date: Time.utc(2015, 06, 13, 16, 00, 00).iso8601)
  create(:match, position: 3, team_1: teams[4], team_2: teams[5], score_team_1: 1, score_team_2: 5, aggregate: group_b, date: Time.utc(2015, 06, 13, 19, 00, 00).iso8601)
  create(:match, position: 4, team_1: teams[6], team_2: teams[7], score_team_1: 3, score_team_2: 1, aggregate: group_b, date: Time.utc(2015, 06, 13, 22, 00, 00).iso8601)
  create(:match, position: 5, team_1: teams[8], team_2: teams[9], score_team_1: 3, score_team_2: 0, aggregate: group_c, date: Time.utc(2015, 06, 14, 16, 00, 00).iso8601)
  create(:match, position: 6, team_1: teams[10], team_2: teams[11], score_team_1: 2, score_team_2: 1, aggregate: group_c, date: Time.utc(2015, 06, 15, 01, 00, 00).iso8601)
  create(:match, position: 7, team_1: teams[12], team_2: teams[13], score_team_1: 1, score_team_2: 3, aggregate: group_d, date: Time.utc(2015, 06, 14, 19, 00, 00).iso8601)
  create(:match, position: 8, team_1: teams[14], team_2: teams[15], score_team_1: 1, score_team_2: 2, aggregate: group_d, date: Time.utc(2015, 06, 14, 22, 00, 00).iso8601)
  create(:match, position: 9, team_1: teams[16], team_2: teams[17], score_team_1: 2, score_team_2: 1, aggregate: group_e, date: Time.utc(2015, 06, 15, 16, 00, 00).iso8601)
  create(:match, position: 10, team_1: teams[18], team_2: teams[19], score_team_1: 3, score_team_2: 0, aggregate: group_e, date: Time.utc(2015, 06, 15, 19, 00, 00).iso8601)
  create(:match, position: 11, team_1: teams[20], team_2: teams[21], score_team_1: 2, score_team_2: 1, aggregate: group_f, date: Time.utc(2015, 06, 15, 22, 00, 00).iso8601)
  create(:match, position: 12, team_1: teams[22], team_2: teams[23], score_team_1: 0, score_team_2: 0, aggregate: group_f, date: Time.utc(2015, 06, 16, 19, 00, 00).iso8601)
  create(:match, position: 13, team_1: teams[24], team_2: teams[25], score_team_1: 4, score_team_2: 0, aggregate: group_g, date: Time.utc(2015, 06, 16, 16, 00, 00).iso8601)
  create(:match, position: 14, team_1: teams[26], team_2: teams[27], score_team_1: 1, score_team_2: 2, aggregate: group_g, date: Time.utc(2015, 06, 16, 22, 00, 00).iso8601)
  create(:match, position: 15, team_1: teams[28], team_2: teams[29], score_team_1: 2, score_team_2: 1, aggregate: group_h, date: Time.utc(2015, 06, 17, 16, 00, 00).iso8601)
  create(:match, position: 16, team_1: teams[30], team_2: teams[31], score_team_1: 1, score_team_2: 1, aggregate: group_h, date: Time.utc(2015, 06, 17, 22, 00, 00).iso8601)
  create(:match, position: 17, team_1: teams[0], team_2: teams[2], score_team_1: 0, score_team_2: 0, aggregate: group_a, date: Time.utc(2015, 06, 17, 19, 00, 00).iso8601)
  create(:match, position: 18, team_1: teams[3], team_2: teams[1], score_team_1: 0, score_team_2: 4, aggregate: group_a, date: Time.utc(2015, 06, 18, 22, 00, 00).iso8601)
  create(:match, position: 19, team_1: teams[4], team_2: teams[6], score_team_1: 2, score_team_2: 3, aggregate: group_b, date: Time.utc(2015, 06, 18, 19, 00, 00).iso8601)
  create(:match, position: 20, team_1: teams[7], team_2: teams[5], score_team_1: 0, score_team_2: 2, aggregate: group_b, date: Time.utc(2015, 06, 18, 16, 00, 00).iso8601)
  create(:match, position: 21, team_1: teams[8], team_2: teams[10], score_team_1: 2, score_team_2: 1, aggregate: group_c, date: Time.utc(2015, 06, 19, 16, 00, 00).iso8601)
  create(:match, position: 22, team_1: teams[11], team_2: teams[9], score_team_1: 0, score_team_2: 0, aggregate: group_c, date: Time.utc(2015, 06, 19, 22, 00, 00).iso8601)
  create(:match, position: 23, team_1: teams[12], team_2: teams[14], score_team_1: 2, score_team_2: 1, aggregate: group_d, date: Time.utc(2015, 06, 19, 19, 00, 00).iso8601)
  create(:match, position: 24, team_1: teams[15], team_2: teams[13], score_team_1: 0, score_team_2: 1, aggregate: group_d, date: Time.utc(2015, 06, 20, 16, 00, 00).iso8601)
  create(:match, position: 25, team_1: teams[16], team_2: teams[18], score_team_1: 2, score_team_2: 5, aggregate: group_e, date: Time.utc(2015, 06, 20, 19, 00, 00).iso8601)
  create(:match, position: 26, team_1: teams[19], team_2: teams[17], score_team_1: 1, score_team_2: 2, aggregate: group_e, date: Time.utc(2015, 06, 20, 22, 00, 00).iso8601)
  create(:match, position: 27, team_1: teams[20], team_2: teams[22], score_team_1: 1, score_team_2: 0, aggregate: group_f, date: Time.utc(2015, 06, 21, 16, 00, 00).iso8601)
  create(:match, position: 28, team_1: teams[23], team_2: teams[21], score_team_1: 1, score_team_2: 0, aggregate: group_f, date: Time.utc(2015, 06, 21, 22, 00, 00).iso8601)
  create(:match, position: 29, team_1: teams[24], team_2: teams[26], score_team_1: 2, score_team_2: 2, aggregate: group_g, date: Time.utc(2015, 06, 21, 19, 00, 00).iso8601)
  create(:match, position: 30, team_1: teams[27], team_2: teams[25], score_team_1: 2, score_team_2: 2, aggregate: group_g, date: Time.utc(2015, 06, 22, 22, 00, 00).iso8601)
  create(:match, position: 31, team_1: teams[28], team_2: teams[30], score_team_1: 1, score_team_2: 0, aggregate: group_h, date: Time.utc(2015, 06, 22, 16, 00, 00).iso8601)
  create(:match, position: 32, team_1: teams[31], team_2: teams[29], score_team_1: 2, score_team_2: 4, aggregate: group_h, date: Time.utc(2015, 06, 22, 19, 00, 00).iso8601)
  create(:match, position: 33, team_1: teams[3], team_2: teams[0], score_team_1: 1, score_team_2: 4, aggregate: group_a, date: Time.utc(2015, 06, 23, 20, 00, 00).iso8601)
  create(:match, position: 34, team_1: teams[1], team_2: teams[2], score_team_1: 1, score_team_2: 3, aggregate: group_a, date: Time.utc(2015, 06, 23, 20, 00, 00).iso8601)
  create(:match, position: 35, team_1: teams[7], team_2: teams[4], score_team_1: 0, score_team_2: 3, aggregate: group_b, date: Time.utc(2015, 06, 23, 16, 00, 00).iso8601)
  create(:match, position: 36, team_1: teams[5], team_2: teams[6], score_team_1: 2, score_team_2: 0, aggregate: group_b, date: Time.utc(2015, 06, 23, 16, 00, 00).iso8601)
  create(:match, position: 37, team_1: teams[11], team_2: teams[8], score_team_1: 1, score_team_2: 4, aggregate: group_c, date: Time.utc(2015, 06, 24, 20, 00, 00).iso8601)
  create(:match, position: 38, team_1: teams[9], team_2: teams[10], score_team_1: 2, score_team_2: 1, aggregate: group_c, date: Time.utc(2015, 06, 24, 20, 00, 00).iso8601)
  create(:match, position: 39, team_1: teams[15], team_2: teams[12], score_team_1: 0, score_team_2: 1, aggregate: group_d, date: Time.utc(2015, 06, 24, 16, 00, 00).iso8601)
  create(:match, position: 40, team_1: teams[13], team_2: teams[14], score_team_1: 0, score_team_2: 0, aggregate: group_d, date: Time.utc(2015, 06, 24, 16, 00, 00).iso8601)
  create(:match, position: 41, team_1: teams[19], team_2: teams[16], score_team_1: 0, score_team_2: 3, aggregate: group_e, date: Time.utc(2015, 06, 25, 20, 00, 00).iso8601)
  create(:match, position: 42, team_1: teams[17], team_2: teams[18], score_team_1: 0, score_team_2: 0, aggregate: group_e, date: Time.utc(2015, 06, 25, 20, 00, 00).iso8601)
  create(:match, position: 43, team_1: teams[23], team_2: teams[20], score_team_1: 2, score_team_2: 3, aggregate: group_f, date: Time.utc(2015, 06, 25, 16, 00, 00).iso8601)
  create(:match, position: 44, team_1: teams[21], team_2: teams[22], score_team_1: 3, score_team_2: 1, aggregate: group_f, date: Time.utc(2015, 06, 25, 16, 00, 00).iso8601)
  create(:match, position: 45, team_1: teams[27], team_2: teams[24], score_team_1: 2, score_team_2: 1, aggregate: group_g, date: Time.utc(2015, 06, 26, 16, 00, 00).iso8601)
  create(:match, position: 46, team_1: teams[25], team_2: teams[26], score_team_1: 0, score_team_2: 1, aggregate: group_g, date: Time.utc(2015, 06, 26, 16, 00, 00).iso8601)
  create(:match, position: 47, team_1: teams[31], team_2: teams[28], score_team_1: 0, score_team_2: 1, aggregate: group_h, date: Time.utc(2015, 06, 26, 20, 00, 00).iso8601)
  create(:match, position: 48, team_1: teams[29], team_2: teams[30], score_team_1: 1, score_team_2: 1, aggregate: group_h, date: Time.utc(2015, 06, 26, 20, 00, 00).iso8601)
  create(:match, position: 49, team_1: teams[0], team_2: teams[6], placeholder_team_1: 'Winner Group A', placeholder_team_2: 'Runner-up Group B', score_team_1: 3, score_team_2: 2, aggregate: round_of_16, date: Time.utc(2015, 06, 28, 16, 00, 00).iso8601)
  create(:match, position: 50, team_1: teams[8], team_2: teams[12], placeholder_team_1: 'Winner Group C', placeholder_team_2: 'Runner-up Group D', score_team_1: 2, score_team_2: 0, aggregate: round_of_16, date: Time.utc(2015, 06, 28, 20, 00, 00).iso8601)
  create(:match, position: 51, team_1: teams[5], team_2: teams[2], placeholder_team_1: 'Winner Group E', placeholder_team_2: 'Runner-up Group F', score_team_1: 2, score_team_2: 1, aggregate: round_of_16, date: Time.utc(2015, 06, 29, 16, 00, 00).iso8601)
  create(:match, position: 52, team_1: teams[13], team_2: teams[9], placeholder_team_1: 'Winner Group G', placeholder_team_2: 'Runner-up Group H', score_team_1: 5, score_team_2: 3, aggregate: round_of_16, date: Time.utc(2015, 06, 29, 20, 00, 00).iso8601)
  create(:match, position: 53, team_1: teams[18], team_2: teams[23], placeholder_team_1: 'Winner Group B', placeholder_team_2: 'Runner-up Group A', score_team_1: 2, score_team_2: 0, aggregate: round_of_16, date: Time.utc(2015, 06, 30, 16, 00, 00).iso8601)
  create(:match, position: 54, team_1: teams[24], team_2: teams[29], placeholder_team_1: 'Winner Group D', placeholder_team_2: 'Runner-up Group C', score_team_1: 2, score_team_2: 1, aggregate: round_of_16, date: Time.utc(2015, 06, 30, 20, 00, 00).iso8601)
  create(:match, position: 55, team_1: teams[20], team_2: teams[16], placeholder_team_1: 'Winner Group F', placeholder_team_2: 'Runner-up Group E', score_team_1: 1, score_team_2: 0, aggregate: round_of_16, date: Time.utc(2015, 07, 1, 16, 00, 00).iso8601)
  create(:match, position: 56, team_1: teams[28], team_2: teams[27], placeholder_team_1: 'Winner Group H', placeholder_team_2: 'Runner-up Group G', score_team_1: 2, score_team_2: 1, aggregate: round_of_16, date: Time.utc(2015, 07, 1, 20, 00, 00).iso8601)
  create(:match, position: 57, team_1: teams[18], team_2: teams[24], placeholder_team_1: 'Winner Match 49', placeholder_team_2: 'Winner Match 50', score_team_1: 0, score_team_2: 1, aggregate: quarter_finals, date: Time.utc(2015, 07, 4, 16, 00, 00).iso8601)
  create(:match, position: 58, team_1: teams[0], team_2: teams[8], placeholder_team_1: 'Winner Match 53', placeholder_team_2: 'Winner Match 54', score_team_1: 2, score_team_2: 1, aggregate: quarter_finals, date: Time.utc(2015, 07, 4, 20, 00, 00).iso8601)
  create(:match, position: 59, team_1: teams[20], team_2: teams[28], placeholder_team_1: 'Winner Match 51', placeholder_team_2: 'Winner Match 52', score_team_1: 1, score_team_2: 0, aggregate: quarter_finals, date: Time.utc(2015, 07, 5, 16, 00, 00).iso8601)
  create(:match, position: 60, team_1: teams[5], team_2: teams[13], placeholder_team_1: 'Winner Match 55', placeholder_team_2: 'Winner Match 56', score_team_1: 4, score_team_2: 3, aggregate: quarter_finals, date: Time.utc(2015, 07, 5, 20, 00, 00).iso8601)
  create(:match, position: 61, team_1: teams[0], team_2: teams[24], placeholder_team_1: 'Winner Match 57', placeholder_team_2: 'Winner Match 58', score_team_1: 1, score_team_2: 7, aggregate: semi_finals, date: Time.utc(2015, 07, 8, 20, 00, 00).iso8601)
  create(:match, position: 62, team_1: teams[5], team_2: teams[20], placeholder_team_1: 'Winner Match 59', placeholder_team_2: 'Winner Match 60', score_team_1: 2, score_team_2: 4, aggregate: semi_finals, date: Time.utc(2015, 07, 9, 20, 00, 00).iso8601)
  create(:match, position: 63, team_1: teams[0], team_2: teams[5], placeholder_team_1: 'Loser Match 61', placeholder_team_2: 'Loser Match 62', score_team_1: 0, score_team_2: 3, aggregate: finals, date: Time.utc(2015, 07, 12, 20, 00, 00).iso8601)
  create(:match, position: 64, team_1: teams[24], team_2: teams[20], placeholder_team_1: 'Winner Match 61', placeholder_team_2: 'Winner Match 62', score_team_1: 1, score_team_2: 0, aggregate: finals, date: Time.utc(2015, 07, 13, 19, 00, 00).iso8601)

  puts "#---------tip creation----------"
  User.players.each do |user|
    champion_tip = build(:champion_tip, user: user, team: teams.sample)
    champion_tip.save(validate: false)

    Match.all.each do |match|
      tip = build(:tip, user: user, match: match)
      tip.save(validate: false)
    end

    Random.rand(5).times.each { create(:comment, user: user) }
  end

  puts "#---------update match result-------"
  Match.all.each do |match|
    MatchResults::Update.run(match_id: match.id, match_result_attributes: {score_team_1: match.score_team_1,
                                                                           score_team_2: match.score_team_2})
  end

  puts "#---------update user badges----"
  UpdateUserBadges.run(group: :tip)

end

if Rails.env == 'production'
  User.create(
      nickname: 'admin',
      first_name: 'Mister',
      last_name: 'Administrator',
      email: 'admin@mail.de',
      password: 'change me immediately',
      password_confirmation: 'change me immediately',
      admin: true,
      match_sort: 'matches.position'
  )

  Property.create(key: Property::TOURNAMENT_TITLE_KEY, value: 'Tournament Title')
  Property.create(key: Property::CHAMPION_TITLE_KEY, value: 'Champion Title')
end