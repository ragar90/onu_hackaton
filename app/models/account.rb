class Account < ActiveRecord::Base
  attr_accessible :amount, :bank_account, :client_id, :fee, :user_id
  belongs_to :user
  belongs_to :client
end
