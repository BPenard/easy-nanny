class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate

      t.timestamps
    end
  end
end
