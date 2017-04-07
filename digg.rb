require 'json'
require 'rest-client'
require_relative 'providers'
require_relative 'module'
require 'colorize'

class Digg < Providers
	attr_accessor :digg,:title, :author, :date, :url, :time, :notices_digg

	def initialize 

		@digg = super 'http://digg.com/api/news/popular.json'
		Digg.attribute (@digg)


	end

	def self.attribute (resourse)

		@notices_digg =[]
		resourse["data"]["feed"].each do |item|

			@title = item["content"]["title"]
			@author = item["content"]["author"]
			@time = item["date"].to_i
			@date=Time.at(item["date"]).to_s
			@date = TOOLS.date_format(@date)
			@url = item["content"]["url"]	
			@notices_digg << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})
		end
		TOOLS.show_notices_providers(@notices_digg)
	end

end