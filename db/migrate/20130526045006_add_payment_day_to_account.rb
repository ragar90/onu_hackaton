class AddPaymentDayToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :payment_day, :date
  end
end
