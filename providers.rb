require 'json'
require 'rest-client'

class Providers
	attr_accessor 
	def initialize uri

		JSON.parse(RestClient.get uri)

	end

end
