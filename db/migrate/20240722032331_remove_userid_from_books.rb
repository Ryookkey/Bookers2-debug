class RemoveUseridFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :userid, :integer
  end
end
