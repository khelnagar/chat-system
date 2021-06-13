class ChangeChatsOfApplication < ActiveRecord::Migration[5.0]
  def change
  	change_column :applications, :chats_count, :integer, :default => 0
  	change_column :applications, :chats_inc, :integer, :default => 1
  end
end