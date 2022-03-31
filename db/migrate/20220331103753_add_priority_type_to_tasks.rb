class AddPriorityTypeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :priority_type, :string
  end
end
