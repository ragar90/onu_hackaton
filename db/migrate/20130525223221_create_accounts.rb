class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :client_id
      t.float :fee
      t.string :bank_account
      t.float :amount

      t.timestamps
    end
  end
end
