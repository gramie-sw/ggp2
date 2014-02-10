FactoryGirl.define do

  factory :team do
    sequence(:country) { |(n)| %w[ZZ BR HR MX CM ES NL CL AU CO GR CI JP UY CR EN IT CH EC FR HN AR BA IR NG DE PT GH US BE DZ RU KR][n % 33] }
  end
end