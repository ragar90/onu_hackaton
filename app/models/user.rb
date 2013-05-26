class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,:registerable,:lockable
  devise 	:database_authenticatable, :recoverable, 
  				:rememberable, :trackable, :validatable
  has_many :accounts
  has_many :clients, :through=>:accounts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :plataform_id,:phone_number,:password,:wallet,:use_mobile_app,
                  :created_at,:updated_at,:email,:encrypted_password,:reset_password_token,
                  :reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,
                  :last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip

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
