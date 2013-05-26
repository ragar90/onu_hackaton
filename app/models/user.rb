class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,:registerable,:lockable
  devise 	:database_authenticatable, :recoverable, 
  				:rememberable, :trackable, :validatable
  has_many :accounts
  has_many :clients, :through=>:accounts
  has_many :user_messages

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
          account.update_attribute(:amount,amount)
        else
          return false
        end
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end

  def self.compare_number(number)
    where("CONCAT('+503', phone_number)=?", number).first rescue nil
  end

  def register_message(sms_sid, sms_message, sms_from, sms_date_sent, data_hash)
    usm = UserMessage.new(user_id: self.id, message_id: sms_sid, message: sms_message, from: sms_from, date_sent: sms_date_sent)
    usm.save

    #HERE GOES THE SHOW
    command = data_hash["command"]
    amount = data_hash["amount"].to_f
    plataform_id = data_hash["plataform_id"]
    account_id = data_hash["account_id"]
    account = Account.find_by_bank_account(account_id)
    token= SecureRandom.hex(len=7).to_i(16).to_s(36)[0..9]
    message = ""
    if !account.nil?
      account.transaction do 
        begin
          if account && self.wallet >= amount
            self.update_attribute(:wallet, self.wallet - amount)
            account.update_attribute(:amount,account+amount)
            at = AccountTransaction.create(:acount_id=>account.id, :amount=>account.ammount.to_f, :transaction_token=>token)
            message = "Hola, gracias por tu pago; Toston te recuerda pagar antes de tu fecha limite para evitar sobrecargos tu codigo de confirmacion es: #{token} "
            sender = SmsMod::Sender.new
            sender.send_message(self.phone_number, message)
          else
            message = "No esta entrando al if"
            sender = SmsMod::Sender.new
            sender.send_message(self.phone_number, message)
            return false
          end
        rescue
          puts "Se genero una excepcion"
          raise ActiveRecord::Rollback
          return false
        end
      end
    else
      message = "Sucedio un problema con tu trasaccion revisa los digitos de tu cuenta y pin"
      sender = SmsMod::Sender.new
      sender.send_message(self.phone_number, message)
    end
    
  end

  def pay_third_service(amount, client_id)
    client = self.clients.find(client_id)
    client.transaction do
      begin
        self.update_attribute(:wallet, self.wallet - amount)
        client.update_attribute(:total_amount,amount)
      rescue
        raise ActiveRecord::Rollback
        return false
      end
    end
  end

end