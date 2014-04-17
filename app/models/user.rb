class User < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :organizations
	has_many :jobapps
	has_many :jobs, through: :jobapps
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

	def applyToJob(jid)
		jb=Job.find(jid)
		if jb.nil?
			return false
		elsif self.jobs.include?(jb)
			return false
		end
		self.jobs << jb
		ja=Jobapp.find_by_user_id_and_job_id(self[:id], jb[:id])
		if ja.nil?
			return false
		end
		ja.status=0
		return self.jobs.include?(jb)
	end

	
end
