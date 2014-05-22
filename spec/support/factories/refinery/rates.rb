
FactoryGirl.define do
  factory :rate, :class => Refinery::Rates::Rate do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

