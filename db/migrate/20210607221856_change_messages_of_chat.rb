class ChangeMessagesOfChat < ActiveRecord::Migration[5.0]
  def change
  	change_column :chats, :messages_count, :integer, :default => 0
  	change_column :chats, :messages_inc, :integer, :default => 1
  end
end
