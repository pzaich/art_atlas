class AddIndexesToPaintings < ActiveRecord::Migration
  def change
    add_index :paintings, :artist_id
    add_index :paintings, :name
    add_index :paintings, :museum_id
  end
end
