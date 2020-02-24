class CreateSelectedRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_restaurants do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
