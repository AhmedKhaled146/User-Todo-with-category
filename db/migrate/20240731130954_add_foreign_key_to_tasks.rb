class AddForeignKeyToTasks < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :tasks, :categories if foreign_key_exists?(:tasks, :categories)
    add_foreign_key :tasks, :categories, on_delete: :cascade
  end
end
