class AddColumnToContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :contracts, :gross_hourly_rate, :float
  end
end
