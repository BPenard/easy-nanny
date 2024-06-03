class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.string :contract_type
      t.integer :weekly_worked_hours

      t.timestamps
    end
  end
end
