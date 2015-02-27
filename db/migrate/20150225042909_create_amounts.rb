class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.references :ingredient, index: true
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :amounts, :ingredients
  end
end
