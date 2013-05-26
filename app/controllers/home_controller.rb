class HomeController < ApplicationController
  def index
  	respond_to do |format|
  		format.json { render :json=> {:message=>"Hola Bienvenido a Toston Cloud Banking"}}
  	end
  end

  def get_user_message
  	File.open('test_get_user_message', 'w') do |f|  
  		f.puts "#{params.inspect}\n"  
	end 
  end

end
