# spec/factories/users.rb

require 'faker'
FactoryGirl.define do
	factory :users do |f|
		f.username { Faker::Internet.user_name }
		f.email { Faker::Internet.email }
	end
end