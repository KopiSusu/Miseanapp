class CreateJoinirtables < ActiveRecord::Migration
  def change
    create_table :joinirtables do |t|
      t.references :recipe, index: true
      t.references :ingredient, index: true

      t.timestamps null: false
    end
    add_foreign_key :joinirtables, :recipes
    add_foreign_key :joinirtables, :ingredients
  end
end
