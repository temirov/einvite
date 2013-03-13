class Authorization < ActiveRecord::Base
  has_secure_password
  
  belongs_to :user, :inverse_of => :authorization
  accepts_nested_attributes_for :user
  attr_accessor :email

  attr_accessible :password, :password_confirmation, :session_token, :new_password, :email, :user_attributes

  after_initialize :build_user, :unless => :user 
  before_save :create_session_token 
  # after_create :update_user_id
  before_create :create_session_token, :update_user_id

  def new_password
    (0...4).map{ SecureRandom.random_number(10) }.join
  end

  private

    def create_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end

    def update_user_id
      user.authorization ||= self
    end

    def create_password
      # Random password
      # @password = (0...8).map{(65+rand(26)).chr}.join

      @password = (0...4).map{ SecureRandom.random_number(10) }.join

      self.password = @password
      self.password_confirmation = @password
    end
end
