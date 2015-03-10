class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :ticker, null: false
      t.string :name, null: false
      t.decimal :price, null: false

      t.timestamps
    end

    add_index(:companies, [:ticker, :name], unique: true)
  end
end
