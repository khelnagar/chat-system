class AddIndexToChats < ActiveRecord::Migration[5.0]
  def change
  	add_index :chats, :number
  end
end
