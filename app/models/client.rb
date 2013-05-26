class Client < ActiveRecord::Base
  attr_accessible :is_loan, :name
  has_many :accounts
  has_many :users, :through=>:accounts
end
