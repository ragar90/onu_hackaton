class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,:registerable,
  devise 	:database_authenticatable, :recoverable, 
  				:rememberable, :trackable, :validatable
  has_many :accounts
  has_many :clients, :through=>:accounts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :plataform_id,:phone_number,:password,:wallet,:use_mobile_app,
                  :created_at,:updated_at,:email,:encrypted_password,:reset_password_token,
                  :reset_password_sent_at,:remember_created_at,:sign_in_count,:current_sign_in_at,
                  :last_sign_in_at,:current_sign_in_ip,:last_sign_in_ip
end
