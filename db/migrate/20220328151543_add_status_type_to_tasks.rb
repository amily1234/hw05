class AddStatusTypeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :status_type, :string
  end
end
