class ChangeSourceToSourceId < ActiveRecord::Migration[5.2]
  def change
  	remove_column :transactions, :source
  	add_column :transactions, :source_id, :integer
  end
end
