
FactoryGirl.define do
  factory :rate_table, :class => Refinery::Rates::RateTable do
    sequence(:title) { |n| "rate table #{n}" }
  end

  factory :effective_date, :class => Refinery::Rates::EffectiveDate do
    effective_at { Time.zone.now }
  end
end

