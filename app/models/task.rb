class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, presence: true
  validates :due_date, presence: true
  validates :description, presence: true
end
