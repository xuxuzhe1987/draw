class AddArrayToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :arrayraw, :integer, array: true, default: []
  end
end
