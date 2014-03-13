class UserMailer < ActionMailer::Base
  
  def registration_confirmation(user)
  	@user = user
  	@url = 'mysterious-woodland-3202.herokuapp.com'
  	mail(:to => @user.email, :subject => "Welcome to R@B", :from => "recruitingatberkeley@gmail.com")
  end
end
