class User < ActiveRecord::Base
  has_one :authorization, 
          :inverse_of => :user, 
          :dependent => :destroy, 
          :autosave => true

  has_and_belongs_to_many :competitions
  
  accepts_nested_attributes_for :authorization, 
                                :update_only => true, 
                                :allow_destroy => true

  accepts_nested_attributes_for :competitions, 
                                :update_only => true

  attr_accessible :email, 
                  :name, 
                  :authorization_attributes, 
                  :competition_attributes

  validates_presence_of :email
  validates_uniqueness_of :email, :unless => :email

  # after_initialize :build_authorization, :unless => :authorization

  before_save { email.downcase! }

  def email_or_name
    self.name || self.email
  end
end
