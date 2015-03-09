class User < ActiveRecord::Base

  has_secure_password

  has_many :memberships
  has_many :projects, through: :memberships
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def all_info
    "#{first_name} #{last_name} #{email}"
  end
end
