class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followable_id, null: false
      t.string :followable_type, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end

    add_index :follows, [:followable_id, :follower_id]
  end
end
