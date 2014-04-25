class Notifier < ActionMailer::Base
	default_url_options[:host] = 'recruitingberkeley.herokuapp.com'

	def verification_instructions(user)
		@user = user
		@url = 'recruitingberkeley.herokuapp.com/user_verifications/' + @user.perishable_token
		mail(:to => @user.email,
			:subject => 'Email Verification',
			:from => 'recruitingatberkeley@gmail.com')
	end
end	