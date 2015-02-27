class DashboardController < ApplicationController
  def index
  	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/dashboard/show')
  	@auth_url = session[:oauth].url_for_oauth_code(permissions: [:read_stream, :email])
  	puts session.to_s + "<<< session"
  	respond_to do |format|
  		format.html {  }
  	end
  end

  def show
  	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/dashboard/show')
  	if params[:code]
  		session[:access_token] = session[:oauth].get_access_token(params[:code])
  	end
  	@api = Koala::Facebook::API.new(session[:access_token])
  	
  	begin
  		@profile = @api.get_object("me")
      # Because of facebook permissions, you are only able to view friends who are also using the same app
  		@friends = @api.get_object("me/friends?fields=id,name,picture")
  	end
  	respond_to do |format|
  		format.html {  }
  	end
  end
end
