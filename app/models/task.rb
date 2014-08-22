class Task < ActiveRecord::Base
  has_many :children, dependent: :destroy, class: Task, foreign_key: "parent_id"
  belongs_to :parent, dependent: :destroy, foreign_key: "parent_id", class: Task

  validates_presence_of :description

  scope :just_parents, ->{ where(parent_id: nil) }
end
