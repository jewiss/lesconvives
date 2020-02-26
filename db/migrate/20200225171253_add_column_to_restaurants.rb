class AddColumnToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :google_api_id, :string
  end
end
