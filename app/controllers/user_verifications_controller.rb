class UserVerificationsController < ApplicationController
	before_filter :load_user_using_perishable_token
	skip_before_filter :require_login

	# /user_verification/{token}

	def show
		if @user
			@user.verify!
			flash[:notice] = "Thank you for verifying your account. You may now login"
		end
		redirect_to '/'
	end

	private

	def load_user_using_perishable_token
		@user = User.find_using_perishable_token(params[:id])
		flash[:notice] = "Unable to find your account." unless @user
	end

end
