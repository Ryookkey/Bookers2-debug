class RemoveUsernameFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :username, :string
  end
end
