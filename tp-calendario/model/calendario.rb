require_relative '../model/evento'

class Calendario

	attr_accessor :evento
	attr_accessor :nombre

	def initialize(nombre)
		self.nombre = nombre
		@evento = Array.new
	end

	def agregarEventoAlCalendario(id)
		@evento.push(id)
	end

	def eliminarEventoDelCalendario(id)
		@evento.delete(id)
	end
		
	def getEvento(id)
		return @evento.key(id)

	end	

	def getTodosLosEventos()
		return @evento.values

	end

	def actualizarEvento(id, inicio, fin)
		@evento.getEvento(id)
		@evento.actualizarEvento(inicio, fin)
	end


end