# frozen_string_literal: true

class AddVotesCounterToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :votes, :integer, default: 0
  end
end
