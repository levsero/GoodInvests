class AddPrevPriceToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :prev_price, :decimal
  end
end
