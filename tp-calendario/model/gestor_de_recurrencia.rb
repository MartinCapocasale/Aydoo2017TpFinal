require_relative '../model/evento'
require 'date'

class GestorDeRecurrencia < Evento

	attr_accessor :frecuencia
	attr_accessor :fin_de_fecha	
	


	def initialize (una_frecuencia,un_fin_de_fecha)
			@frecuencia = una_frecuencia
			@fin_de_fecha = Date.parse(un_fin_de_fecha)
	end



end