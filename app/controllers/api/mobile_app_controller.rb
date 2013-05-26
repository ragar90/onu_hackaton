class Api::MobileAppController < ApplicationController

	respond_to :json
	
	def get_accounts
		user = current_user2

		respond_to do |format|
			format.json { render :json => {wallet: user.wallet, accounts: user.accounts, status: 1} }
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

	def process_payment
		user = current_user2
		if user.check_pass(params[:password])
			response = user.make_payment(params[:amount].to_f, params[:id])
			if response
				code = 1 #success
			else
				code = 2 #no enough money
			end
		else
			code = 0 #bad pass
		end

		respond_to do |format|
			format.json { render :json => {status: code} }
		end
	end

	def current_user2
		User.first
	end

end
