FactoryGirl.define do
  factory :user, aliases: [:player] do
    nickname { Forgery::Name.first_name }
    first_name { Forgery::Name.first_name }
    last_name { Forgery::Name.last_name }
    email { Forgery::Internet.email_address }
    password { Forgery::Basic.password(at_least: 8) }
    password_confirmation { "#{password}" }
    points {0}
    admin false

    factory :admin do
      admin true
    end
  end
end