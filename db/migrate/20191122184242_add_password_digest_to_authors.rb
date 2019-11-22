class AddPasswordDigestToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :password_digest, :digest
  end
end
