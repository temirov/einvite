class Authorization < ActiveRecord::Base
  has_secure_password
  # validate :authorization_must_be_less_than_2_hours_old
  
  # validates :updated_at, :numericality => { :greater_than_or_equal_to => lambda {|time| where("updated_at > ?", time)},
  #                                           :message => "Your authorization has expired." }

  # validates_numericality_of :updated_at,
  #   :unless => lambda { |a| a.updated_at < 2.hours.ago },
  #   :message => "Your authorization has expired."
  
  belongs_to :user, 
             :inverse_of => :authorization, 
             :autosave => true

  accepts_nested_attributes_for :user, 
                                :update_only => true

  attr_accessor :email, :new_password

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
  
  def self.with_valid_update_time(time=2.hours.ago)
    where('updated_at >= ?', time)
  end
  
  def recently_updated?(time=2.hours.ago)
    updated_at >= time
  end

  private
    #unused
    def authorization_must_be_less_than_2_hours_old
      errors.add :base, "Your previous authorization has expired." unless 
        updated_at.present? and updated_at >= 2.hours.ago
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
