class AddConstrainToCategories < ActiveRecord::Migration[7.2]
  def change
    change_column :categories, :name, :string, null: false
    add_index :categories, [:user_id, :name], unique: true
  end
end
