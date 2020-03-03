class AddOpeningHoursToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :opening_hours, :string
  end
end
