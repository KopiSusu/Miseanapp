class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.references :ingredient, index: true
      t.float :quantity

      t.timestamps null: false
    end
    add_foreign_key :amounts, :ingredients
  end
end
