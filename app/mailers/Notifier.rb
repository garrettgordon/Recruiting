class Notifier < ActionMailer::Base
	default_url_options[:host] = 'mysterious-woodland-3202.herokuapp.com'

	def verification_instructions(user)
		@user = user
		@url = 'mysterious-woodland-3202.herokuapp.com/user_verifications/' + @user.perishable_token
		mail(:to => @user.email,
			:subject => 'Email Verification',
			:from => 'recruitingatberkeley@gmail.com')
	end
end	