class NestedCommentsDepth < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :ancestry_depth, :integer, :default => 0
  end
end
