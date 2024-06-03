class UpdateTypeToContracts < ActiveRecord::Migration[7.1]
  def change
    rename_column :contracts, :contract_type, :type
  end
end
