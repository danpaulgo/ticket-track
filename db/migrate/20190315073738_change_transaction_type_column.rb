class ChangeTransactionTypeColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :transactions, :type, :direction
  end
end
