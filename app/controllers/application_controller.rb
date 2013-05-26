class ApplicationController < ActionController::Base
  #protect_from_forgery

	after_filter :set_access_control_headers
	 
	def set_access_control_headers
	# Rails 2
	#@response.headers["Access-Control-Allow-Origin"] = 'http://xxx.xxx.xxx.xxx:yyyy'
	#@response.headers['Access-Control-Request-Method'] = 'GET, PUT, POST, DELETE'
	# Rails 2.3.8
	#response.headers["Access-Control-Allow-Origin"] = 'http://xxx.xxx.xxx.xxx:yyyy'
	#response.headers['Access-Control-Request-Method'] = 'GET, PUT, POST, DELETE'
	# Rails 3
		headers['Access-Control-Allow-Origin'] = 'http://xxx.xxx.xxx.xxx:yyyy'
		#headers['Access-Control-Request-Method'] = 'GET, PUT, POST, DELETE'
		#headers["content-type"] = "image/png"
	end

end
