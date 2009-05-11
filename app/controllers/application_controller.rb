# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	helper :all # include all helpers, all the time
  	protect_from_forgery # See ActionController::RequestForgeryProtection for details

  	# Scrub sensitive parameters from your log
  	# filter_parameter_logging :password
	CONTACTS_SCOPE = 'http://www.google.com/m8/feeds/'
	CALENDAR_SCOPE = 'http://www.google.com/calendar/feeds/'
 	def setup_goog_client
		logger.debug "setup called"
		@client = GData::Client::Contacts.new
		if params[:token].nil? and session[:token].nil?
			logger.debug "setting up"
			scope = CONTACTS_SCOPE
			next_url = 'http://localhost:3000/welcome/'
			secure = false
			sess = true
			@authsub_link = @client.authsub_url(next_url,secure,true)
			logger.debug('link '+@authsub_link)
		elsif params[:token] and session[:token].nil?
			logger.debug "got token"
			@goog_ok = true
			@client.authsub_token = params[:token]
			session[:token] = @client.auth_handler.upgrade()
		end
		@client.authsub_token = session[:token] if session[:token]
	end
end
