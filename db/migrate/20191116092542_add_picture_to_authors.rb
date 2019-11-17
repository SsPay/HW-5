class AddPictureToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :picture, :string
  end
end
