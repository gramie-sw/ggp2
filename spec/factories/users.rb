FactoryGirl.define do
  factory :user, aliases: [:player] do
    sequence(:nickname) { |n| "#{Forgery::Name.first_name}_#{n}" }
    first_name { Forgery::Name.first_name }
    last_name { Forgery::Name.last_name }
    sequence(:email) { |n| "player_#{n}@test.de" }
    password { Forgery::Basic.password(at_least: 8) }
    password_confirmation { "#{password}" }
    active true
    admin false

    factory :admin do
      admin true
    end
  end
end