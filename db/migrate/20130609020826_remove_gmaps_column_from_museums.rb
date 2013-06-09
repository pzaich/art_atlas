class RemoveGmapsColumnFromMuseums < ActiveRecord::Migration
  def up
    remove_column :museums, :gmaps
  end

  def down
    add_column :museums, :gmaps, :boolean
  end
end
