class RenameSourceId < ActiveRecord::Migration[5.2]
  def change
  	rename_column :transactions, :source_id, :transaction_source_id
  end
end
