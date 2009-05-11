class WelcomeController < ApplicationController
	
	before_filter :setup_goog_client
	def index
		@goog_login_link = @authsub_link
	end
	def logout
		@client.auth_handler.revoke()
		render :text => "you have been logout " and return
	end
	def feeds
		feed = @client.get('http://www.google.com/calendar/feeds/default/allcalendars/full').to_json
		render :text => feed
	end
end
