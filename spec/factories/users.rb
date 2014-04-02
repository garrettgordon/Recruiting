require 'faker'

FactoryGirl.define do
	factory :user do |f|
		f.username { 'john' }
		f.email { 'andrewmori@berkeley.edu' }
		f.password { 'pass' }
		f.password_confirmation { 'pass' }
		f.verified { 'true' }
	end
end