class AddTitleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :icon, :text
  end
end
