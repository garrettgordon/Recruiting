class UserSessionsController < ApplicationController
  # before_action :set_user_session, only: [:show, :edit, :update, :destroy]
  skip_before_filter :require_login
  
  # GET /user_sessions/new
  def new
    @user_session = UserSession.new
  end


  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      if current_user.recruiter
        redirect_to current_user
      else
      #flash[:notice] = "SUCCESS LOGIN!"
        redirect_to '/home'
      end
    else
      flash[:login_notice] = "Invalid Login!"
      redirect_to "/"
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    logger.debug "IN DESTROY"
    @user_session = UserSession.find
    @user_session.destroy
    #flash[:notice] = "SUCCESS LOGOUT!"
    redirect_to root_url
  end

end
