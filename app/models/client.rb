class Client < ActiveRecord::Base
  attr_accessible :name,:is_bank,:created_at,:updated_at ,:total_money
  has_many :accounts
  has_many :users, :through=>:accounts
end
