class AddUserIdToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :user, index: true, foreign_key: true
  end
end
