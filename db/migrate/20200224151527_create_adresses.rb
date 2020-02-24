class CreateAdresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :full_address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
