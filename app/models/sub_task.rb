class SubTask < ActiveRecord::Base
  belongs_to :task

  validates_presence_of :description

  scope :by_task, ->(task_id) { where("task_id = ?", task_id) }
end
