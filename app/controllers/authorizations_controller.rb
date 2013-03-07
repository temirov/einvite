class AuthorizationsController < ApplicationController

  # GET /authorizations/new
  # GET /authorizations/new.json
  def new
    @authorization = Authorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authorization }
    end
  end

  def create
#    debugger
    email = params[:authorization][:user][:email].downcase
    user = User.find_by_email(email)
    if user
      if authorization.find_by_session_token(cookies[:session_token]).try(:authenticate, params[:password])
        # Sign the user in and redirect to the user's show page.
        sign_in
        redirect_to root_url
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
    else
      @authorization = Authorization.new(params[:authorization])

      respond_to do |format|
        if @authorization.save
          sign_in @authorization.user
          format.html { redirect_to @authorization, notice: 'Authorization was successfully created.' }
          format.json { render json: @authorization, status: :created, location: @authorization }
        else
          format.html { render action: "new" }
          format.json { render json: @authorization.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end
