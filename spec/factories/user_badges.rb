FactoryGirl.define do

  factory :user_badge do
    association :user
    sequence(:position) { |n| n }
    icon { ['icon_1', 'icon_2', 'icon_3'].sample }
    icon_color { "%06x" % (rand * 0xffffff)}
    group { ['comment', 'tip'].sample }
    badge_identifier { Ggp2.config.badges_registry_instance.grouped_badges[group.to_sym].sample.identifier }
  end
end