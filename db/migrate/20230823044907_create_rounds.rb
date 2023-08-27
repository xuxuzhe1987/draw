class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds do |t|
      t.string :num
      t.string :target
      t.string :keyword

      t.timestamps
    end
  end
end
