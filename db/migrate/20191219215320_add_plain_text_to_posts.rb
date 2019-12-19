class AddPlainTextToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :plain_text, :text
  end
end
