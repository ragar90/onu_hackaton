# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Account.destroy_all
User.destroy_all
Client.destroy_all

c1 = nil
c2 = nil
c3 = nil
if Client.count == 0
	puts "Creating Clients"
	c1 = Client.create(:name=>"Banco1",:is_bank=>true, :total_money=>1000.50)
	c2 = Client.create(:name=>"Banco2",:is_bank=>true, :total_money=>1000.50)
	c3 = Client.create(:name=>"Banco3",:is_bank=>true, :total_money=>1000.50)
else
	c1 = Client.find(1)
	c2 = Client.find(2)
	c3 = Client.find(3)	
end

if User.count == 0
	puts "Creating Users"
	for i in 1..10 do
		u=User.create(:plataform_id=>SecureRandom.hex(len=7).to_i(16).to_s(36)[0..5],:wallet=>100,:password=>"123456789",:email=>"rene.garcia#{i}@gmail.com")
		puts "Creating Accunt"
		if i%2 == 0
			u.accounts << Account.new(:client_id=>c1.id, :fee=>50.0,:payment_day=>Date.today+5.days,:is_loan=>true,:total_loan=>500.00,:balance_paid=>0,:amount=>30, :bank_account=>SecureRandom.hex(len=7).to_i(16).to_s(36)[0..9])
		elsif i%3 == 0
			u.accounts << Account.new(:client_id=>c2.id, :fee=>50.0,:payment_day=>Date.today+5.days,:is_loan=>true,:total_loan=>500.00,:balance_paid=>0,:amount=>30, :bank_account=>SecureRandom.hex(len=7).to_i(16).to_s(36)[0..9])
		else
			u.accounts << Account.new(:client_id=>c3.id, :fee=>50.0,:payment_day=>Date.today+5.days,:is_loan=>true,:total_loan=>500.00,:balance_paid=>0,:amount=>30, :bank_account=>SecureRandom.hex(len=7).to_i(16).to_s(36)[0..9])
		end
	end

end