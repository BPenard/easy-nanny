class ChangeColumnToEvent < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :date, :start_date
    change_column :events, :start_date, :datetime

  end
end
