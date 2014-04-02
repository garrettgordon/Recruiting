# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :organization do |o|
    o.name {"Name"}
    o.description {"Description"}
    o.location {"Location"}
    o.link {"Link"}
  end
end
