class Task < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments

  belongs_to :project
  validates :description, presence: true
end
