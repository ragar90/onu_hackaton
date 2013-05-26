class Account < ActiveRecord::Base
  attr_accessible :user_id,:client_id,:fee,:bank_account,:amount,:created_at,:updated_at ,:payment_day,:is_loan,:total_loan,:balance_paid
  belongs_to :user
  belongs_to :client

  def modify_loan(value = self.total_loan*0.5)
  	self.total_loan += value
  	self.save 
  end

  def is_loan_paid?
  	self.total_loan == self.balance_paid
  end

  def self.transfer_money
  	accounts = self.where(:payment_day=>Date.today+5.days)
  	accounts.each do |account|
  		if account.is_loan and !account.is_loan_paid? and account.amount>0
				puts "Procesando cuenta #{account.bank_account}"
				puts "cuenta #{account.bank_account} saldo => #{account.amount}"
				fee = account.fee
				# curl -X POST --data "mother_count_type=xxxx&from=cuenta_madre_x&to=user_bank_acpunt"
				if account.amount>=fee
					account.amount -= fee
					account.client.total_money += fee
					account.balance_paid += fee
					account.save
					account.client.save
				elsif account.amount<fee
					account.client.total_money += account.amount
					account.balance_paid += account.amount
					account.amount = 0
					account.modify_loan
					account.save
					account.client.save
				end 
				puts "cuenta #{account.bank_account} saldo => #{account.amount}"
  		end
  	end
  end
  has_many :account_transactions

  def new_transaction(pay_amount)
  	update_attribute("amount", self.amount + pay_amount)
  	AccountTransaction.create!(account_id: self.id, amount: pay_amount)
  	true
  end
end
