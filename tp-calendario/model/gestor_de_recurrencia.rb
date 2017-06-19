require 'date'
require_relative './frecuencia'
require_relative './evento'

class GestorDeRecurrencia

	attr_accessor :frecuencia
	attr_accessor :fechaFin	
	attr_accessor :nuevo_evento
	
	def initialize (una_frecuencia,una_fechaFin)
			@frecuencia = una_frecuencia
			@fechaFin = DateTime.parse(una_fechaFin)
			@nuevo_evento = []
			

	end

	def calcular_recurrencia(gestor_de_recurrencia)
		  una_frecuencia = @frecuencia.set_Frecuencia(gestor_de_recurrencia.obtener_frecuencia)
		  fechaFin = gestor_de_recurrencia.obtener_fecha_fin
		  fechaActual = evento.get_fecha_inicio()
		  hora_ini = evento.get_fecha_inicio()
		  hora_fin = evento.get_fecha_fin()
		  i = 0
	      j = 1
	   	  while fechaActual <= fechaFin do
	   	    @nuevo_evento[i] = fechaActual
	   	    @nuevo_evento[j] = hora_fin
	   	    fechaActual = una_frecuencia.calcular(fechaActual)
	   	    hora_fin = una_frecuencia.calcular(hora_fin)
	   	    i = i + 2
	   	    j = j + 2
		  end
	end

	def obtener_frecuencia
	  	return @frecuencia
	end

    def obtener_fecha_fin
	    return @fechaFin
	end

	def obtenerEvento
	  return @nuevo_evento
	end
end