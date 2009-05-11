class ContactsController < ApplicationController
	before_filter :setup_goog_client

	CONTACTS_FEED = CONTACTS_SCOPE + 'contacts/default/full'

	def all
		feed = @client.get(CONTACTS_FEED +
			"?max-results=500").to_xml
		
		@owner = feed.elements['title'].text 
		#render :text => @owner and return
		@contacts = []
		feed.elements.each('entry') do |entry|
			entry.elements.each('gd:email') do |email|
			#	if email.attribute('primary')
			#		contact = entry.elements['title'].text
					contact = email.attribute("address").value
			#	end

			@contacts.push(contact)
			end
		end
		@acl_feedlink = params[:acl_feedlink]
#		render :json => @contacts.to_json
	end
			
end
