class User < ActiveRecord::Base
  attr_accessible :password, :phone_number, :plataform_id, :wallet, :use_mobile_app
end
