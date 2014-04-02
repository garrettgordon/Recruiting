# spec/factories/events.rb

require 'faker'
FactoryGirl.define do
	factory :event do |f|
		f.name { Faker::Name.name }
		f.location { Faker::Address.street_address }
		f.description { Faker::Lorem.sentence }
		f.date  {Date.new}
<<<<<<< HEAD
		f.id {1}
=======
		f.id { 1 }
>>>>>>> cd65a18a371484a9f4a8d42cf710d93fca41a8a8
	end
end

