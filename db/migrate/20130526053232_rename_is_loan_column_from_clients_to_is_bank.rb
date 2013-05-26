class RenameIsLoanColumnFromClientsToIsBank < ActiveRecord::Migration
  def up
  	rename_column :clients, :is_loan, :is_bank
  	add_column :accounts, :is_loan, :boolean
  	add_column :accounts, :total_loan, :float
  	add_column :accounts, :balance_paid, :float
  end

  def down
  	rename_column :clients, :is_bank, :is_loan
  	remove_column :accounts, :is_loan
  	remove_column :accounts, :total_loan
  	remove_column :accounts, :balance_paid
  end
end
