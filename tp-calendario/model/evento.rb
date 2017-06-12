#require_relative '.model/exception_validacion_de_duracion'

class Evento
	attr_reader :nombre
	attr_reader :id
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :recurrencia
	attr_accessor :nombre_calendario


	def initialize(id, nombre, inicio, fin, recurrencia, nombre_calendario)
		#validar_Tiempo_De_Duracion(inicio, fin)
		@inicio = inicio
		@nombre = nombre
		@fin = fin
		@id = id
		@recurrencia = recurrencia
		@nombre_calendario = nombre_calendario
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
