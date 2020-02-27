class AddShortAddressToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :short_address, :string
  end
end
