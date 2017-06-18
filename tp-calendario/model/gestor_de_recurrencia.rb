require 'date'

class GestorDeRecurrencia 

	attr_accessor :frecuencia
	attr_accessor :fechaFin	
	
	def initialize (una_frecuencia,una_fechaFin)
			@frecuencia = una_frecuencia
			@fechaFin = DateTime.parse(una_fechaFin)
	end

	def obtener_frecuencia
	  	return @frecuencia
	end

    def obtener_fecha_fin
	    return @fechaFin
	end
end