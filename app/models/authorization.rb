class Authorization < ActiveRecord::Base
  has_secure_password
  
  belongs_to :user, :inverse_of => :authorization
  accepts_nested_attributes_for :user, :update_only => true
  attr_accessor :email, :new_password

  attr_accessible :password, :password_confirmation, :session_token, :new_password, :email, :user_attributes, :plain_password

  after_initialize :build_user, :unless => :user 
  before_validation :create_new_password, :unless => :password
  before_save :create_session_token, :unless => :session_token
  # , :create_new_password, :sync_passwords
  # before_validation :create_session_token, :create_new_password, :sync_passwords

  private
    def create_session_token(length=64)
      self.session_token = SecureRandom.urlsafe_base64(length)
    end

    def create_new_password
      self.new_password = (0...4).map{ SecureRandom.random_number(10) }.join
      self.plain_password = self.new_password
      self.password = self.new_password
      self.password_confirmation = self.new_password
    end

    def sync_passwords
      self.plain_password = self.new_password
      self.password = self.new_password
      self.password_confirmation = self.new_password
    end

    def create_password
      # Random password
      # @password = (0...8).map{(65+rand(26)).chr}.join

      @password = (0...4).map{ SecureRandom.random_number(10) }.join

      self.password = @password
      self.password_confirmation = @password
    end
    
    def self.sweep(time = 2.hour)
      if time.is_a?(String)
        time = time.split.inject { |count, unit| count.to_i.send(unit) }
      end
   
      delete_all "updated_at < '#{time.ago.to_s(:db)}'"
    end
end
