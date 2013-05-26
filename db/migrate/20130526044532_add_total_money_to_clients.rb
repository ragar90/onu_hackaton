class AddTotalMoneyToClients < ActiveRecord::Migration
  def change
    add_column :clients, :total_money, :float
  end
end
