require 'json'
require 'rest-client'
require_relative 'providers'
require_relative 'module'
require 'colorize'

class Mashable < Providers
	attr_accessor :mashable, :title, :author, :date, :url, :time, :notices_mashable

	def initialize 

		@mashable = super 'http://mashable.com/stories.json'
		Mashable.attributes (@mashable)

	end

	def self.attributes (resourse)

		@notices_mashable=[]
		resourse.each_key do |key|
			category=resourse["#{key}"]
			if category != nil 
				category.each do |item|
					@title = item["title"]
					@author = item["author"]
					@time = Time.parse(item["post_date"]).to_i
					@date = Time.parse(item["post_date"]).to_s
					@date = TOOLS.date_format(@date)	
					@url = item["link"]
					@notices_mashable << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})		
				end
			end
		end
		TOOLS.show_notices_providers(@notices_mashable)
	end
end