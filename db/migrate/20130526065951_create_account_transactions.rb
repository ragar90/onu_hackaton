class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.references :account
      t.float :amount

      t.timestamps
    end
    add_index :account_transactions, :account_id
  end
end
