class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.text :body, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :comments, :commentable_id
  end
end
