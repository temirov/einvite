class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # debugger
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:email].downcase, params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
