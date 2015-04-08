class Task < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  belongs_to :project
  validates :description, presence: true
end
