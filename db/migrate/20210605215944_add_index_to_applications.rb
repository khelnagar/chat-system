class AddIndexToApplications < ActiveRecord::Migration[5.0]
  def change
  	add_index :applications, :application_token
  end
end
