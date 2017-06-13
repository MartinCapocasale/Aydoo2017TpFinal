require_relative './validacion_de_duracion'

class Evento
	attr_reader :nombre
	attr_reader :id
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :recurrencia
	attr_accessor :nombre_calendario
	

	def initialize(id, nombre, inicio, fin, recurrencia, nombre_calendario)
		ValidacionDeDuracion.new(inicio, fin)
		@inicio = inicio
		@nombre = nombre
		@fin = fin
		@id = id
		@recurrencia = recurrencia
		@nombre_calendario = nombre_calendario
	end

	def actualizarEvento(inicioNuevo, finNuevo)
		ValidacionDeDuracion.new(inicioNuevo, finNuevo)
		@inicio = inicioNuevo
		@fin = finNuevo
	end

	def setInicio(incio)
		@inicio = inicio
	end

	def setFin(fin)
		@fin = fin
	end	

end	
