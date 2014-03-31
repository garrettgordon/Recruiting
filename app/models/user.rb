class User < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :organizations
	acts_as_authentic do |config|
		config.perishable_token_valid_for = 1.hour
	end

	def deliver_verification_instructions!
		reset_perishable_token!
		Notifier.verification_instructions(self).deliver!
	end

	def verify!
		self.verified = true
		self.save
	end
end
