class AddAvatarColumnsToMuseums < ActiveRecord::Migration
  def up
    add_attachment :museums, :avatar
  end

  def down
    remove_attachment :museums, :avatar
  end
end
