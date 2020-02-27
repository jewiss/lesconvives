class AddPlaceIdGoogleToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :place_id_google, :string
  end
end
