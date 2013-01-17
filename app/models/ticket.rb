class Ticket < ActiveRecord::Base
  attr_accessible :description, :urgency
  validates :description, :urgency, :presence => true
  validates :urgency, :numericality => true, :length => { :maximum => 10 }
  belongs_to :user
end
