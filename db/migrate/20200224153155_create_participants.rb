class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :owner, default: false
      t.boolean :attending, default: true
      t.references :address, null: false, foreign_key: true
      t.boolean :voted, default: false

      t.timestamps
    end
  end
end
