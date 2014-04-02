require 'faker'

FactoryGirl.define do
	factory :user_session do |f|
		f.username { 'john' }
		f.password { 'pass' }
		f.id {1}
	end
end