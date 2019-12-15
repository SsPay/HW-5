# frozen_string_literal: true

class AddLoginEmailPasswordToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :login, :string
    add_index :authors, :login, unique: true
    add_column :authors, :email, :string
    add_index :authors, :email, unique: true
  end
end
