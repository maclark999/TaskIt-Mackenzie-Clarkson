class Task < ActiveRecord::Base
  belongs_to :projects
  validates :description, presence: true
end
