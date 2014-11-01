class Member < ActiveRecord::Base

  attr_accessible :id, :first_name, :last_name, :home_phone, :zip, :city, :dd_dues_date, :work_phone, :state, :user_attributes, :cell_phone, :caf_col_no, :active, :street_2, :street_1
  belongs_to :user
  accepts_nested_attributes_for :user, :allow_destroy => true
  
  has_many :event_signups
  has_many :events, :through => :event_signups
  has_many :terms
  has_many :officer_positions, :through => :terms

  scope :active, where("members.active = 1")

  scope :ordered, order("members.last_name ASC, members.first_name ASC")

  def full_name
    self.last_name + ', ' + self.first_name
  end

end
