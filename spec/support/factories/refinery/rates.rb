
FactoryGirl.define do
  factory :rate_table, :class => Refinery::Rates::RateTable do
    sequence(:title) { |n| "rate table #{n}" }
  end
end

