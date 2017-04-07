require 'json'
require 'rest-client'
require_relative 'providers'
require_relative 'module'
require 'colorize'


class Reddit < Providers
	attr_accessor :reddit, :title, :author, :date, :url, :time, :notices_reddit

	def initialize 

		@reddit = super 'http://reddit.com/.json'
		Reddit.attributes(@reddit)
		
	end

	def self.attributes (resourse)
		@notices_reddit =[] 
		resourse["data"]["children"].each do |item|

			@title = item["data"]["title"]
			@author = item["data"]["author"]
			@time = item["data"]["created"].to_i
			@date=Time.at(item["data"]["created"]).to_s
			@date = TOOLS.date_format(@date)
			@url = "http://reddit.com/.json"+item["data"]["permalink"]
			@notices_reddit << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})		
																																							
		end

		TOOLS.show_notices_providers(@notices_reddit)	
	end

end