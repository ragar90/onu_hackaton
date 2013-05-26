class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,:registerable,
  devise 	:database_authenticatable, :recoverable, 
  				:rememberable, :trackable, :validatable
  has_many :accounts
  has_many :clients, :through=>:accounts
  has_many :user_messages

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

  def self.compare_number(number)
    where("CONCAT('+503', phone_number)=?", number).first rescue nil
  end

  def register_message(sms_sid, sms_message, sms_from, sms_date_sent, data_hash)
    usm = UserMessage.new(user_id: self.id, message_id: sms_sid, message: sms_message, from: sms_from, date_sent: sms_date_sent)
    usm.save

    #HERE GOES THE SHOW
    command = data_hash["command"]
    amount = data_hash["amount"]
    plataform_id = data_hash["plataform_id"]
    account_id = data_hash["account_id"]

    message = "Hola, gracias por tu pago; los datos que enviaste son: #{command},#{amount},#{plataform_id},#{account_id}"
    sender = SmsMod::Sender.new
    sender.send_message(self.phone_number, message)
  end

end