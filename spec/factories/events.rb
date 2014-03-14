# spec/factories/events.rb

require 'faker'
FactoryGirl.define do
	factory :event do |f|
		f.name { Faker::Name.name }
		f.location { Faker::Address.street_address }
		f.description { Faker::Lorem.sentence }
		f.date  {Date.new}
	end
end

FactoryGirl.define do
	factory :user do |f|
		f.username { Faker::Internet.user_name }
		f.email { Faker::Internet.email }
	end
end
