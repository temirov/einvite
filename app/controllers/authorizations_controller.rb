class AuthorizationsController < ApplicationController

  # GET /authorizations/new
  # GET /authorizations/new.json
  def new
    @authorization = Authorization.new

    respond_to do |format|
      format.html
      format.json { render json: @authorization }
    end
  end

  def create
    debugger

    @user = User.find_by_email(params[:authorization][:user_attributes][:email].downcase)

    # TODO: Horrible code
    # MUST refactor 

    if @user.present?
      @authorization = @user.authorization
      if @authorization.try(:authenticate, params[:authorization][:password])
        successful_authorization @authorization
      else
        unsuccessful_authorization @authorization
      end
    else
      @authorization = Authorization.new(params[:authorization])
      if @authorization.save
        successful_authorization @authorization 
      else
        unsuccessful_authorization @authorization 
      end   
    end

    # @authorization.save ? successful_authorization(@authorization) : unsuccessful_authorization(@authorization)
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end

  private
    def successful_authorization(authorization)
      debugger
      sign_in authorization
      # redirect_to session[:return_to], notice: 'Authorization was successful'
      # session.delete(:return_to)
      # redirect_to :back, notice: 'Authorization was successful'

      respond_to do |format|
        format.html { redirect_to edit_user_path(authorization.user.id) }
      end
      
    #   redirect_to :back
    # rescue ActionController::RedirectBackError
    #   # redirect_to root_path
    #   respond_to do |format|
    #     format.html { redirect_to edit_user_path(authorization.user.id) }
    #   end
    end
    
    def unsuccessful_authorization(authorization)
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: authorization.errors, status: :unprocessable_entity }
      end
    end
end
