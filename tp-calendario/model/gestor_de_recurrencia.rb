require_relative '../model/evento'
require 'date'

class GestorDeRecurrencia 

	attr_accessor :frecuencia
	attr_accessor :fechaFin	
	
	def initialize (una_frecuencia,una_fechaFin)
			@frecuencia = una_frecuencia
			@unafechaFin = DateTime.parse(una_fechaFin)
	end

	def obtener_Frecuencia
	  	return @frecuencia
	end

    def obtener_Fecha_fin
	    return @unafechaFin
	end
end