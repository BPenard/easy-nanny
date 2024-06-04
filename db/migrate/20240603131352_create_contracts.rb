class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.string :type
      t.integer :weekly_worked_hours
      t.float :gross_hourly_rate
      t.references :nanny_id, null: false
      t.references :parent_id, null: false

      t.timestamps
    end
    add_foreign_key :contracts, :users, column: :nanny_id
    add_foreign_key :contracts, :users, column: :parent_id
  end
end
