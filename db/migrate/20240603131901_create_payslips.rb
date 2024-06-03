class CreatePayslips < ActiveRecord::Migration[7.1]
  def change
    create_table :payslips do |t|
      t.date :month_of_payslip
      t.float :paid_amount
      t.date :payment_date
      t.float :employer_contributions
      t.float :employee_contributions
      t.float :gross_salary
      t.float :tax_rate
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
