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

  def pay_credit_loan(amount, client_id)
    account = account_for(client_id)
     account.transaction do 
      begin
        if account && self.wallet >= amount
          self.update_attribute(:wallet, self.wallet - amount)
          acccount.update_attribute(:amount,amount)
        else
          return false
        end
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end

  def pay_third_service(amount, client_id)
    client = self.clients.find(client_id)
    client.transaction do
      begin
        self.update_attribute(:wallet, self.wallet - amount)
          acccount.update_attribute(:total_amount,amount)
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end
end
