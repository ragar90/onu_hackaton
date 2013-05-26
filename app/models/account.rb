class Account < ActiveRecord::Base
  attr_accessible :amount, :bank_account, :client_id, :fee, :user_id
  belongs_to :user
  belongs_to :client
  has_many :account_transactions

  def new_transaction(pay_amount)
  	update_attribute("amount", self.amount + pay_amount)
  	AccountTransaction.create!(account_id: self.id, amount: pay_amount)
  	true
  end

end
