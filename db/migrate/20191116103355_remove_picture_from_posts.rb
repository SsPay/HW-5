class RemovePictureFromPosts < ActiveRecord::Migration[6.0]
  def change

    remove_column :posts, :picture, :string
  end
end
