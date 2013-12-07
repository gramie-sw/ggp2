FactoryGirl.define do

  factory :team do
    sequence(:country) { |n| %w[BR HR MX CM ES NL CL AU CO GR CI JP UY CR ENGLAND IT CH EC FR HN AR BA IR NG DE PT GH US BE DZ RU KR][n-1] }
  end
end