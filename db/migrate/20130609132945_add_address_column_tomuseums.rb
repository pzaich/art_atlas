class AddAddressColumnTomuseums < ActiveRecord::Migration
  def change
    add_column :museums, :address, :string
  end
end
