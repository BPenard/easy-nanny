class CreateChildContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :child_contracts do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
