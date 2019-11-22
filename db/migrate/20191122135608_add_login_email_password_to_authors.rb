class AddLoginEmailPasswordToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :login, :string
    add_index :authors, :login, unique: true
    add_column :authors, :email, :string
    add_index :authors, :email, unique: true
    add_column :authors, :password, :digest
  end
end
