require 'json'
require 'rest-client'
require_relative 'providers'
require_relative 'reddit'
require_relative 'mashable'
require_relative 'digg'
require_relative 'notice'
require_relative 'module'
require 'colorize'

def main

	TOOLS.welcome
	TOOLS.menu
end

main