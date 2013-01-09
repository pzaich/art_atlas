class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.string :name
      t.float :latitude
      t.float :longtitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
