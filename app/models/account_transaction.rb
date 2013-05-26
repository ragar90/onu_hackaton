class AccountTransaction < ActiveRecord::Base
  belongs_to :account
  attr_accessible :account_id,:amount,:created_at,:updated_at,:transaction_token
end
