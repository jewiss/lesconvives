class RemovePhotoUrlFromRestaurants < ActiveRecord::Migration[6.0]
  def change

    remove_column :restaurants, :photo_url, :string
  end
end
