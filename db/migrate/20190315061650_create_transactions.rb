class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :event_id
      t.integer :user_id
      t.float :amount
      t.string :type

      t.timestamps
    end
  end
end
