class User < ActiveRecord::Base
  validates :name, :email, :presence => true
  attr_accessible :email, :name, :password
  scope :recent,order("created_at desc")
  has_many :tickets, :dependent => :nullify
end
