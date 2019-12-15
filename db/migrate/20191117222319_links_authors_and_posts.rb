# frozen_string_literal: true

class LinksAuthorsAndPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :author
    end
end
