class User < ActiveRecord::Base
  has_one :authorization, :dependent => :destroy
  accepts_nested_attributes_for :authorization, :allow_destroy => true
  attr_accessible :email, :name, :authorization_attributes

  validates_presence_of :email
  validates_uniqueness_of :email

#  after_initialize :build_authorization, :unless => :authorization

  before_save { email.downcase! }

  # def self.authenticate(email, password)
  #   find_by_email(email).try(:authenticate, password)
  #   Authorization.find_by_id(user.id)
  # end

  # def self.add_provider(auth_hash)
  #   Authorization.create :user => self
  #   # Check if the provider already exists, so we don't add it twice
  #   unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  #     Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  #   end
  # end
end
