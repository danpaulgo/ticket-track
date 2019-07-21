class ChangeFacebookIdToStringInUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :facebook_id, :string
  end
end
