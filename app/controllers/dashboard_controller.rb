class DashboardController < ApplicationController
  def index
  	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/dashboard/show')
  	@auth_url = session[:oauth].url_for_oauth_code(permissions: [:read_stream, :user_friends, :user_birthday, :email])
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
  		@friends = @api.get_object("me/friends")
      # @email = @api.get_object("me/email")
  	end
  	respond_to do |format|
  		format.html {  }
  	end
    puts 'USER ----------------------'
    puts @profile
    puts 'FRIENDS ----------------------'
    puts @friends
    # puts 'EMAIL ----------------------'
    # puts @email
  end
end
