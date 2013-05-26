class UserMessage < ActiveRecord::Base
  belongs_to :user
  attr_accessible :date_sent, :from, :message, :message_id, :user_id
end
