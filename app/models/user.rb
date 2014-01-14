class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  validates_uniqueness_of :username

  has_many :assignments, :dependent => :destroy
  accepts_nested_attributes_for :assignments

  has_many :roles, :through => :assignments

#  def self.current_user
#    session[:current_user]
#  end

  def can?(action, resource)
    roles.includes(:rights).for(action, resource).any?
  end

#  belongs_to :member


  has_one :member, :dependent => :destroy
#  accepts_nested_attributes_for :member, :allow_destroy => true


end
