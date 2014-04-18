# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :organization do |o|
    o.name {"yelp"}
    o.description {"we analyze big data"}
    o.location {"SF"}
    o.link {""}
  end
end
