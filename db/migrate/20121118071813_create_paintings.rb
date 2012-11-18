class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.integer :artist_id

      t.timestamps
    end
  end
end
