class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthorizationsHelper

  def signed_in_user
    unless signed_in?     
      respond_to do |format|
        format.html { redirect_to login_path } 
      end
    end
  end  
end
