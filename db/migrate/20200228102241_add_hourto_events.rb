class AddHourtoEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :hour, :time
  end
end
