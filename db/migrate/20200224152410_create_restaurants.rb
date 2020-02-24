class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :price_level
      t.integer :rating
      t.string :food_category
      t.string :address
      t.string :phone
      t.string :url

      t.timestamps
    end
  end
end
