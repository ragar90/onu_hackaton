class AccountTransaction < ActiveRecord::Base
  belongs_to :account
  attr_accessible :amount, :account_id
end
