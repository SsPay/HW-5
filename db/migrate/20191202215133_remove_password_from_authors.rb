class RemovePasswordFromAuthors < ActiveRecord::Migration[6.0]
  def change
    remove_column :authors, :password, :digest
  end
end
