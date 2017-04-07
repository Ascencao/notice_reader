require 'json'
require 'rest-client'

# require_relative 'reddit'
# require_relative 'digg'
# require_relative 'mashable'

class Providers

	def initialize uri

		JSON.parse(RestClient.get uri)

	end

end
#----------------------------------------------------------------------------------
		#Proveedor Reddit

# require 'json'
# require 'rest-client'
# require_relative 'providers'

class Reddit < Providers
	attr_accessor :reddit, :title, :author, :date, :url, :time, :notices_reddit

	def initialize 

		@reddit = super 'http://reddit.com/.json'
		Reddit.attributes (@reddit)
		
	end

	def self.attributes (resourse)
		@notices_reddit =[] 
		resourse["data"]["children"].each do |item|

			@title = item["data"]["title"]
			@author = item["data"]["author"]
			@time = item["data"]["created"].to_i
			@date=Time.at(item["data"]["created"]).to_s
			@date = Tools.date_format(@date)
			@url = item["data"]["permalink"]
			@notices_reddit << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})		
																																							
		end
		Tools.show_notices_providers(@notices_reddit)	
	end

end
#----------------------------------------------------------------------------------
		#Proveedor Mashable

# require 'json'
# require 'rest-client'
# require_relative 'providers'

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
					@date = Tools.date_format(@date)	
					@url = item["link"]
					@notices_mashable << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})		
				end
			end
		end
		Tools.show_notices_providers(@notices_mashable)
	end
end
#----------------------------------------------------------------------------------
		#Proveedor Digg

# require 'json'
# require 'rest-client'
# require_relative 'providers'

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
			@date = Tools.date_format(@date)
			@url = item["content"]["url"]	
			@notices_digg << Notice.new({"title" => @title, "author" => @author, "date" => @date, "time" => @time, "url" => @url})
		end
		Tools.show_notices_providers(@notices_digg)
	end

end

#----------------------------------------------------------------------------------
		#Noticias

# require 'json'
# require 'rest-client'
# require_relative 'reddit'
# require_relative 'mashable'
# require_relative 'digg'

class Notice

	attr_accessor :title, :author, :date, :url, :time, :attributes
	@@notice=[]
	def initialize (attributes={})

		@title = attributes["title"]
		@author = attributes["author"]
		@date = attributes["date"]
		@time = attributes["time"]
		@url = attributes["url"]
		@@notice<< attributes

	end

	def self.all
	
			TOOLS.show_notices_providers(@@notice)
			@@notice
			
	end

end
#----------------------------------------------------------------------------------
		#Módulo
module Tools

	def self.date_format (date)

		date=date.split (" ")
		date=date.first
		date=date.split ("-")
		date_aux=date[2]
		date[2]=date[0]
		date[0]=date_aux
		date=date.join("-")

	end

	def self.create_providers
		#Reddit.new
		#Mashable.new
		 Digg.new
	end

	def self.show_notices_providers(notices)
		tiempo = notices
		tiempo.sort! {|x,y| x.time <=> y.time }
		tiempo.each do |item|
			puts "--------------------------------------------------------------------------------------------------"
			print "Título: #{item.title}."
			puts
			puts "--------------------------------------------------------------------------------------------------"
			print "Fecha: #{item.date}. 		Escrito por: #{item.author}"
			puts
			puts "#{item.url} #{item.time}" 
			puts "--------------------------------------------------------------------------------------------------"
			puts 
			puts
		end	
	end

end
##############################################################
###########################TESTING############################

Tools.create_providers