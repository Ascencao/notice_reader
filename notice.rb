require_relative 'module'
require 'colorize'

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
end