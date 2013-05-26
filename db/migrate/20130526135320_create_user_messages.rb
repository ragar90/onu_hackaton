class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.references :user
      t.string :message_id
      t.string :message
      t.string :from
      t.datetime :date_sent

      t.timestamps
    end
    add_index :user_messages, :user_id
  end
end
