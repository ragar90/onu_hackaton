class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :plataform_id
      t.string :phone_number
      t.string :password
      t.float :wallet
      t.boolean :use_mobile_app, :default=>false

      t.timestamps
    end
  end
end
