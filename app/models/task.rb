class Task < ActiveRecord::Base
  has_many :sub_tasks, dependent: :destroy

  validates_presence_of :description
end
