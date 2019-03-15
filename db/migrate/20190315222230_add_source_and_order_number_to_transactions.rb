class AddSourceAndOrderNumberToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :source, :string
    add_column :transactions, :order_number, :string
  end
end
