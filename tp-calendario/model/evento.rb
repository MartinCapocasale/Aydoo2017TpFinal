#require_relative '.model/exception_validacion_de_duracion'

class Evento
	attr_reader :nombre
	attr_reader :id
	attr_accessor :incio
	attr_accessor :fin
	attr_accessor :incio
	attr_accessor :recurrencia


	def initialize(id, nombre, inicio, fin, recurrencia)
		#validar_Tiempo_De_Duracion(inicio, fin)
		@incio = incio
		@nombre = nombre
		@fin = fin
		@id = id
		@recurrencia = recurrencia
	end


	def validar_Tiempo_De_Duracion(inicio, fin)
		intervalo = (fin - inicio)
    	raise ExceptionValidacionDeDuracion if fin < inicio

    	if(intervalo <=72)
    	end	
  	end


	def actualizarEvento(inicioNuevo, finNuevo)
		@inicio = inicioNuevo
		@fin = finNuevo
	end


end	
