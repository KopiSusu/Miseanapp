class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|

      t.timestamps null: false
    end
  end
end
