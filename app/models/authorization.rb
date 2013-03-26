class Authorization < ActiveRecord::Base
  scope :with_valid_session_tokens, lambda { where('updated_at >= ?', 2.hours.ago) }
  has_secure_password
  
  belongs_to :user, 
             :inverse_of => :authorization, 
             :autosave => true

  accepts_nested_attributes_for :user, 
                                :update_only => true

  attr_accessor :email, :new_password

  attr_reader :recent
  alias :recent? :recent

  attr_accessible :password, 
                  :new_password, 
                  :session_token, 
                  :email, 
                  :user_attributes

  after_initialize :build_user, :unless => :user 
  before_validation :create_password, :unless => :password
  before_save :create_session_token, :unless => :session_token
  after_commit :send_password_notification
  validates_associated :user

  private

    def recent
      @recent = self.with_valid_session_tokens.present?
    end

    def create_password
      # Random password
      # @password = (0...8).map{(65+rand(26)).chr}.join
      self.new_password = (0...4).map{ SecureRandom.random_number(10) }.join
      self.password = self.new_password
      self.password_confirmation = self.new_password
    end

    def send_password_notification
      PasswordMailer.password_email(self).deliver
    end

    def create_session_token(length=64)
      self.session_token = SecureRandom.urlsafe_base64(length)
    end
end
