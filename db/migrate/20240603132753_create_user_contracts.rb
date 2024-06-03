class CreateUserContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_contracts do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
