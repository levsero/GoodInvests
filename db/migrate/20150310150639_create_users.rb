class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.string :job_title
      t.text :description
      t.string :session_token, null: false

      t.timestamps
    end

    add_index(:users, [:email, :session_token], unique: true)
  end
end
