#!/bin/env ruby
# encoding: utf-8
class Api::MobileAppController < ApplicationController

	respond_to :json
	
	def get_accounts
		user = current_user2

		respond_to do |format|
			format.json { render :json => {wallet: user.wallet, accounts: user.accounts, status: 1} }
		end
	end

	def service_clients
		clients = Client.where(:is_bank=>false)
		respond_to do |format|
			format.json{ render :json=>clients }
		end 
	end

	def get_account_info
		user = current_user2
		account = user.account_for(params[:id])

		if !account.nil?
			result = {wallet: user.wallet, account: account, transactions: account.account_transactions, status: 1}
		else
			result = {status: 0}
		end

		respond_to do |format|
			format.json { render :json => result }
		end
	end

	def proccess_credit(user,amount,client_id)
		return_values = {}
		response = user.pay_credit_loan(amount,client_id)
		if !user.check_pass(params[:password])
			return_values[:message] = "Contraseña incorrecta, no se puede realizar la transaccion"
			return_values[:code] = 0 #bad pass
			return_values[:confirmation_token] = ""
		elsif response
			return_values[:code] = 1 #success
			return_values[:message] = "Abono a credito realizado con exito"
			account = AccountTransaction.create(:acount_id=>account_for(params[:client_id]).id, :amount=>params[:amount].to_f, :transaction_token=>Devise.freadly_token)
			return_values[:confirmation_token] = account.transaction_token
			
		else
			return_values[:message] = "No hay suficiente saldo para realizar este abono"
			return_values[:code] = 2 #no enough money
			return_values[:confirmation_token] = ""
		end
		return return_values
	end

	def proccess_service(user,amount,client_id)
		return_values = {}
		response = user.pay_third_service(amount,client_id)
		if !user.check_pass(params[:password])
			return_values[:message] = "Contraseña incorrecta, no se puede realizar la transaccion"
			return_values[:code] = 0 #bad pass
			return_values[:confirmation_token] = ""
		elsif response
			return_values[:code] = 1 #success
			return_values[:message] = "Pago realizado con exito"
			return_values[:confirmation_token] = Devise.freadly_token
			
		else
			return_values[:message] = "No hay suficiente saldo para realizar este abono"
			return_values[:code] = 2 #no enough money
			return_values[:confirmation_token] = ""
		end
		return return_values
	end

	#Proceso de pago de "wallet" a "cuenta madre"
	def process_payments
		user = current_user2
		return_values = type == "credit" ? proccess_credit(user,params[:amount].to_f, params[:client_id]) : proccess_service(user,params[:amount].to_f, params[:client_id])
		respond_to do |format|
			format.json { render :json => return_values.to_json }
		end
	end

	def current_user2
		@user = User.where(:plataform_id=>params[:user_id]).first
	end

end
