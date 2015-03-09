class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :role, presence: true

  enum role: {member: 0, owner: 1}
end
