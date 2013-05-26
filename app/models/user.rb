class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,:registerable,
  devise 	:database_authenticatable, :recoverable, 
  				:rememberable, :trackable, :validatable
  has_many :accounts
  has_many :clients, :through=>:accounts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :password, :phone_number, :plataform_id, :wallet, :use_mobile_app

  def account_for(account_id)
    accounts.where(id: account_id).first rescue nil
  end

  def check_pass(pass)
    valid_password?(pass)
  end

  def make_payment(amount, id)
    account = account_for(id)
    if account && self.wallet >= amount
      update_attribute("wallet", self.wallet - amount)
      account.new_transaction(amount)
    else
      false
    end
  end

end
