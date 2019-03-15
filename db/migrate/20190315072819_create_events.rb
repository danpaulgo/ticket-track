class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :performer_id
      t.integer :venue_id
      t.date :date

      t.timestamps
    end
  end
end
