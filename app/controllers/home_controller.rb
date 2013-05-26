class HomeController < ApplicationController
  def index
  	respond_to do |format|
  		format.json { render :json=> {:message=>"Hola Bienvenido a Toston Cloud Banking"}}
  	end
  end
end
