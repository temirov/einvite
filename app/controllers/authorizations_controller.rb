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
      reset_session
      if @authorization.try(:authenticate, params[:authorization][:password])
        sign_in @authorization
        format.html { redirect_to edit_user_path(@authorization.user), notice: 'Logged in successfully' }
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
        authorization_redirect(@authorization.update_attributes(params[:authorization]))
#        if @authorization.update_attributes(params[:authorization])
#          format.html { redirect_to edit_authorization_path(@authorization), notice: 'Password was sent successfully.' }
#          format.json { render json: @authorization, status: :created, location: @authorization }
#        else
#          format.html { render action: "new" }
#          format.json { render json: @authorization.errors, status: :unprocessable_entity }
#        end
      else
        @authorization = Authorization.new(params[:authorization])
        authorization_redirect(@authorization.save)
#        if @authorization.save
#          format.html { redirect_to edit_authorization_path(@authorization), notice: 'Password was sent successfully.' }
#          format.json { render json: @authorization, status: :created, location: @authorization }
#        else
#          format.html { render action: "new" }
#          format.json { render json: @authorization.errors, status: :unprocessable_entity }
#        end
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
      @authorization = authorization
      respond_to do |format|
        format.html { redirect_to edit_authorization_path(@authorization), notice: 'New password has been sent successfully.' }
        format.json { render json: @authorization, status: :created, location: @authorization }
      end
    end
    
    def unsuccessful_authorization(authorization)
      @authorization = authorization
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
end
