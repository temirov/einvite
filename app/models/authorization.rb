class Authorization < ActiveRecord::Base
  has_secure_password
  
  belongs_to :user, :inverse_of => :authorization
  accepts_nested_attributes_for :user
  attr_accessor :email, :new_password, :session_token

  attr_accessible :password, :password_confirmation, :session_token, :new_password, :email, :user_attributes

  after_initialize :build_user, :unless => :user 
  after_initialize :create_new_password
  before_save :create_session_token, :sync_passwords

  private

    def create_session_token
      debugger
      self.session_token = SecureRandom.urlsafe_base64
    end

    def create_new_password
      self.new_password = (0...4).map{ SecureRandom.random_number(10) }.join
    end

    def sync_passwords
      self.plain_password = self.password
      self.password_confirmation = self.password
    end

    def create_password
      # Random password
      # @password = (0...8).map{(65+rand(26)).chr}.join

      @password = (0...4).map{ SecureRandom.random_number(10) }.join

      self.password = @password
      self.password_confirmation = @password
    end
end
