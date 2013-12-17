class AddIndexesToMuseums < ActiveRecord::Migration
  def change
    add_index :museums, [:latitude, :longitude]
  end
end
