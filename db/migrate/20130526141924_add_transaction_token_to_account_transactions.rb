class AddTransactionTokenToAccountTransactions < ActiveRecord::Migration
  def change
    add_column :account_transactions, :transaction_token, :string
  end
end
