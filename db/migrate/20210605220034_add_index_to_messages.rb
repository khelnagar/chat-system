class AddIndexToMessages < ActiveRecord::Migration[5.0]
  def change
  	add_index :messages, :number
  end
end
