class AddUseridToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :userid, :integer
  end
end
