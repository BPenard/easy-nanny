class AddColumnToPayslip < ActiveRecord::Migration[7.1]
  def change
    add_column :payslips, :paje_emploi_send_date, :date
    add_column :payslips, :bank_send_date, :date
  end
end
