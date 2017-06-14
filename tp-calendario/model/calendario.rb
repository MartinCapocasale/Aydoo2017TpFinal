require_relative './evento'
require_relative './validacion_de_nombre_calendario'
require_relative './exception_unico_evento'

class Calendario

	attr_accessor :evento
	attr_accessor :nombre
	@@calendarios = {}

	def initialize(nombre)
		ValidacionDeNombreCalendario.new(nombre)
		@nombre = nombre
		@evento = {}
		@@calendarios[nombre]
	end

	def eliminarCalendario(nombre)
		@@calendarios.delete[nombre]
	end	

	def getTotalDeCalendarios()
		return @@calendarios.size()
	end

	def agregarEventoAlCalendario(nuevo_evento)
		@evento[nuevo_evento.id] = nuevo_evento
	end
		
	def eliminarEventoDelCalendario(id)
		@evento.delete[id]
	end
		
	def getEvento(id)
		return @evento[id]

	end	

	def getTotalDeEventos()
		return @evento.size()

	end

	def actualizarEvento(id, inicio, fin)
		@evento.getEvento(id)
		@evento.actualizarEvento(inicio, fin)
	end

	def unico_evento_del_calendario(id)
		raise ExceptionUnicoEvento if @evento[id] == evento.id

	end	
end