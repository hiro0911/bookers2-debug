class CreateRooms < ActiveRecord::Migration[5.2]
  def change
  	drop_table :rooms
    create_table :rooms do |t|
t.references :user
      t.timestamps
    end
  end
end
