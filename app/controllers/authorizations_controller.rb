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

  def edit
    @authorization = Authorization.find(params[:id])
  end

  def update
    @authorization = Authorization.find(params[:id])

    respond_to do |format|
      if @authorization.try(:authenticate, params[:authorization][:password])
        reset_session
        sign_in @authorization
        format.html { redirect_to edit_user_path(@authorization.user), notice: 'Logged in successfully.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @authorization = Authorization.includes(:user).where("users.email" => params[:authorization][:user_attributes][:email].downcase).first
    # TODO: redundant code, refactor!

    respond_to do |format|
      if @authorization.present? 
        if @authorization.update_attributes(params[:authorization])
          # PasswordMailer.password_email(@authorization).deliver        
          # PasswordMailer.delay.password_email(@authorization)        
          format.html { redirect_to edit_authorization_path(@authorization), notice: 'Password was sent successfully.' }
          format.json { render json: @authorization, status: :created, location: @authorization }
        else
          format.html { render action: "new" }
          format.json { render json: @authorization.errors, status: :unprocessable_entity }
        end
      else
        @authorization = Authorization.new(params[:authorization])
        if @authorization.save
          # PasswordMailer.password_email(@authorization).deliver
          # PasswordMailer.delay.password_email(@authorization)
          format.html { redirect_to edit_authorization_path(@authorization), notice: 'Password was sent successfully.' }
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

  private
    def authorization_redirect(authorization_block)
      if authorization_block
        successful_authorization @authorization 
      else
        unsuccessful_authorization @authorization 
      end 
    end

    def successful_authorization(authorization)
      debugger
      PasswordMailer.password_email(authorization).deliver
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
