class Competition < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :user_attributes
  accepts_nested_attributes_for :users
end
