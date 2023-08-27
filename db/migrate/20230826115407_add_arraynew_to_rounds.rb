class AddArraynewToRounds < ActiveRecord::Migration[7.0]
  def change
    add_column :rounds, :arraynew, :integer, array: true, default: []
  end
end
