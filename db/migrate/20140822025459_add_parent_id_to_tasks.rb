class AddParentIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :parent_id, :integer
    add_index :tasks, :parent_id
  end
end
