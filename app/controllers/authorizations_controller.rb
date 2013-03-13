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
    @user = User.find_by_email(params[:authorization][:user_attributes][:email].downcase)
    if @user
      if @user.authorization.try(:authenticate, params[:authorization][:password])
        successful_authorization @user
      else
        unsuccessful_authorization @user.authorization
      end
    else
      @authorization = Authorization.new(params[:authorization])
      if @authorization.save
        successful_authorization @authorization.user
      else
        unsuccessful_authorization @authorization
      end
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end

  private
    def successful_authorization(user)
      sign_in user
      # redirect_to session[:return_to], notice: 'Authorization was successful'
      # session.delete(:return_to)
      # redirect_to :back, notice: 'Authorization was successful'
      respond_to do |format|
        format.html { redirect_to edit_user_path(user.id) }
      end
    end
    
    def unsuccessful_authorization(authorization)
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: authorization.errors, status: :unprocessable_entity }
      end
    end
end
