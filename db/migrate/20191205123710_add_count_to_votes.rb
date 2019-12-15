# frozen_string_literal: true

class AddCountToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :count, :integer
  end
end
