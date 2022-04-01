class AddTagIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :tag_id, :integer
  end
end
