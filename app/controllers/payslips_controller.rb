class PayslipsController < ApplicationController

  def index
    @payslips = policy_scope(Payslip)
  end
end
