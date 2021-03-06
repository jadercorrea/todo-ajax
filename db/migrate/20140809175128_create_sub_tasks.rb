class CreateSubTasks < ActiveRecord::Migration
  def change
    create_table :sub_tasks do |t|
      t.string :description
      t.boolean :finished
      t.belongs_to :task, index: true

      t.timestamps
    end
  end
end
