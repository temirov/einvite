class AuthorizationsController < ApplicationController
  # before_filter :signed_in_user, :except=>[:new, :create]

  # GET /authorizations/new
  # GET /authorizations/new.json
  def new
    if signed_in
      @authorization = Authorization.new(params[:authorization])
    else
      @authorization = Authorization.new
    end

    respond_to do |format|
      format.html
      format.json { render json: @authorization }
    end
  end

  def create
    debugger
    @user = User.find_or_create_by_email(params[:authorization][:user_attributes][:email].downcase)
    # @authorization = Authorization.find_or_create_by_user(@user)
    @authorization = Authorization.new(params[:authorization])
    @authorization.user = @user

    @authorization.save ? successful_authorization(@authorization) : unsuccessful_authorization(@authorization)

    # @user = User.find_by_email(params[:authorization][:user_attributes][:email].downcase)
    # if @user
    #   if @user.authorization.try(:authenticate, params[:authorization][:password])
    #     successful_authorization @user
    #   else
    #     unsuccessful_authorization @user.authorization
    #   end
    # else
      
    #   if @authorization.save
    #     successful_authorization @authorization.user
    #   else
    #     unsuccessful_authorization @authorization
    #   end
    # end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end

  private
    def successful_authorization(authorization)
      sign_in authorization
      # redirect_to session[:return_to], notice: 'Authorization was successful'
      # session.delete(:return_to)
      # redirect_to :back, notice: 'Authorization was successful'
      respond_to do |format|
        format.html { redirect_to edit_user_path(authorization.user.id) }
      end
    end
    
    def unsuccessful_authorization(authorization)
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: authorization.errors, status: :unprocessable_entity }
      end
    end

    # def signed_in_user
    #   debugger
    #   # store the initial path
    #   if signed_in?
    #     respond_to do |format|
    #       format.html { redirect_to login_path, notice: "Please sign in." }
    #     end
    #   end
    # end
end
