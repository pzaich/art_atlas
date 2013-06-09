class RemoveColumnsFromPaintings < ActiveRecord::Migration
  def up
    remove_column :paintings, :gmaps
    remove_column :paintings, :latitude
    remove_column :paintings, :longitude
  end

  def down
    add_column :paintings, :gmaps, :boolean
    add_column :paintings, :latitude, :float
    add_column :paintings, :longitude, :float
  end
end
