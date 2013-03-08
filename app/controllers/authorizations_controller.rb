class AuthorizationsController < ApplicationController

  # GET /authorizations/new
  # GET /authorizations/new.json
  def new
    debugger
    @authorization = Authorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authorization }
    end
  end

  def create
    debugger
    @user = User.find_by_email(params[:authorization][:user_attributes][:email].downcase)
    if @user
      if @user.authorization.try(:authenticate, params[:authorization][:user_attributes][:password])
        # Sign the user in and redirect to the requested page.
        # redirect_to root_url
        successful_authorization
      else
        debugger
        # flash.now[:error] = 'Invalid email/password combination'
        # render 'new'
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    else
      @authorization = Authorization.new(params[:authorization])

      respond_to do |format|
        if @authorization.save
          successful_authorization
          # redirect_to root_url
          # sign_in @authorization.user
          # format.html { redirect_to session[:return_to], notice: 'Authorization was successfully created.' }
          # format.json { render json: @authorization, status: :created, location: @authorization }
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

  private
    def successful_authorization
      sign_in @user
      redirect_to session.delete(:return_to), notice: 'Authorization was successful'
    end
end
