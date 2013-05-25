class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.boolean :is_loan, :default=>true

      t.timestamps
    end
  end
end
