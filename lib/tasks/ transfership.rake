desc "Esta tarea hace el traspaso mensual de la cuenta maestra a las cuentas bancarias"
task :transfer_to_banks => :environment do
  puts "Transferiendo dinero a cuentas bancarias...."
  Account.transfer_money
  puts "Hecho."
end