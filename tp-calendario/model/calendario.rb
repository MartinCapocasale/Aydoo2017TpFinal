require_relative './evento'
require_relative './validacion_de_nombre_calendario'

class Calendario

	attr_accessor :evento
	attr_accessor :nombre

	def initialize(nombre)
		ValidacionDeNombreCalendario.new(nombre)
		@nombre = nombre
		@evento = {}
	end

	def agregarEventoAlCalendario(nuevo_evento)
		@evento[nuevo_evento.id] = nuevo_evento
	end
		
	def eliminarEventoDelCalendario(id)
		@evento.delete(id)
	end
		
	def getEvento(id)
		return @evento[id]

	end	

	def getTodosLosEventos()
		return @evento.values

	end

	def actualizarEvento(id, inicio, fin)
		@evento.getEvento(id)
		@evento.actualizarEvento(inicio, fin)
	end


end