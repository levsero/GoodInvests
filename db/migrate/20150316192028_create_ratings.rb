class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rateable_id, null: false
      t.string :rateable_type, null: false
      t.integer :rater_id, null: false
      t.integer :rating, null: false

      t.timestamps
    end

    add_index :ratings, [:rateable_id, :rater_id]
  end
end
