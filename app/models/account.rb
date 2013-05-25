class Account < ActiveRecord::Base
  attr_accessible :amount, :bank_account, :client_id, :fee, :user_id
end
