require 'json'
require 'rest-client'
require_relative 'reddit'
require_relative 'mashable'
require_relative 'digg'
require_relative 'notice'
require 'colorize'
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
module TOOLS										# Módulo
	attr_accessor :opc

	def self.date_format (date)		#Da formato DD/MM/AA al date

		date=date.split (" ")
		date=date.first
		date=date.split ("-")
		date_aux=date[2]
		date[2]=date[0]
		date[0]=date_aux
		date=date.join("-")

	end
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def self.show_notices_providers(notices)		#Muestra las Noticias
		
		tiempo = notices
		tiempo.sort! {|x,y| x.time <=> y.time }
				tiempo.each do |item|
					puts "	__________________________________________________________________________________________________________________________".blue
					puts 
					puts "	Título: #{item.title}.".blue
					puts "	__________________________________________________________________________________________________________________________"	.blue	
					puts
					print "	Escrito por: #{item.author}.".light_blue
					puts
					print "	Fecha: #{item.date}".light_blue
					puts " URL: #{item.url} ".light_blue
					puts "	__________________________________________________________________________________________________________________________".blue
					puts 
		end	
	end
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def self.welcome  				 #Pantalla Principal
		system("clear")
		puts	
		puts	
		puts
		puts
		puts
		puts
		puts "                         |&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|".light_blue
		puts "                         |&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|      &&&&&     &&   &&&&&&   &&   &&   &&    &&   &&&&&&   &&   &&   &&   &&&&&&     &&&&&       |&&|".light_blue
		puts "                         |&&|      &&  &&    &&   &&       &&&  &&   &&    &&   &&       &&&  &&   &&   &&   &&   &&   &&      |&&|".light_blue
		puts "                         |&&|      &&&&&&    &&   &&&&     && & &&   &&    &&   &&&&     && & &&   &&   &&   &&   &&   &&      |&&|".light_blue
		puts "                         |&&|      &&   &&   &&   &&       &&  &&&    &&  &&    &&       &&  &&&   &&   &&   &&   &&   &&      |&&|".light_blue
		puts "                         |&&|      &&&&&&    &&   &&&&&&   &&   &&      &&      &&&&&&   &&   &&   &&   &&&&&&     &&&&&       |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                               &&&                                                |&&|".light_blue
		puts "                         |&&|                                              && &&                                               |&&|".light_blue
		puts "                         |&&|                                             &&   &&                                              |&&|".light_blue
		puts "                         |&&|                                             &&&&&&&                                              |&&|".light_blue
		puts "                         |&&|                                             &&   &&                                              |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                            &&       &&&&&&   &&&&&   &&   &&    &&&&&                            |&&|".light_blue
		puts "                         |&&|                            &&       &&      &&       &&&  &&   &&   &&                           |&&|".light_blue
		puts "                         |&&|                            &&       &&&&    &&       && & &&   &&   &&                           |&&|".light_blue
		puts "                         |&&|                            &&       &&      &&       &&  &&&   &&   &&                           |&&|".light_blue
		puts "                         |&&|                            &&&&&&&  &&&&&&   &&&&&   &&   &&    &&&&&                            |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|                                                                                                  |&&|".light_blue
		puts "                         |&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|".light_blue
		puts "                         |&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|&&|".light_blue
		puts
		puts "                                                                 SU LECTOR DE NOTICIAS ON-LINE".blue
		puts
		gets
	end
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	def self.menu			# Menú Principal

		system("clear")
		puts 
		puts "   ______________________________________________________________________________________________________________________________________________".light_blue
		puts "   |                                                                                                                                             |".light_blue
		puts "   |                   	                                          MENÚ DE NOTICIEROS                                                             |".light_blue
		puts "   |_____________________________________________________________________________________________________________________________________________|".light_blue
		puts
		puts
		print "                                  1.Reddit ".blue
		print "               2.Mashable".blue
		print "               3.Digg".blue
		print "               4.Todos ".blue
		puts
		puts
		puts
		puts "                                                          Seleccione la opción de su preferencia".light_blue
		puts
		print "                                                                             "
		@opc = get_keypressed.to_i
		puts
			
		case @opc
		when 1
			system("clear")
			puts "    _____________________________________________________________________________________________________________________________________________".light_blue
			puts "   |                                                                                                                                             |".light_blue
			puts "                      	                                          REDDIT                                                             ".light_blue
			puts "   |_____________________________________________________________________________________________________________________________________________|".light_blue
			puts
			puts
			Reddit.new
		when 2
			system("clear")
			puts "    _____________________________________________________________________________________________________________________________________________".light_blue
			puts "   |                                                                                                                                             |".light_blue
			puts "                      	                                          MASHABLE                                                             ".light_blue
			puts "   |_____________________________________________________________________________________________________________________________________________|".light_blue
			puts
			puts
			Mashable.new
		when 3
			system("clear")
			puts "    _____________________________________________________________________________________________________________________________________________".light_blue
			puts "   |                                                                                                                                             |".light_blue
			puts "                      	                                          DIGG                                                             ".light_blue
			puts "   |_____________________________________________________________________________________________________________________________________________|".light_blue
			puts
			puts
			Digg.new
		else
			puts "Opción no Válida"
		end
				

	end
			
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
								#Función que devuelve el valor recibido por teclado
	def self.get_keypressed	
		system("stty raw -echo")
		t = STDIN.getc
		system("stty -raw echo")
		return t
	end
end