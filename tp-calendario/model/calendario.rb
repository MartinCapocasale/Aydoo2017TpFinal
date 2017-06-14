require_relative './evento'
require_relative './validacion_de_nombre_calendario'
require_relative './exception_unico_evento'
require_relative './exception_los_eventos_se_solapan'

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
		validar_unico_evento_del_calendario(nuevo_evento.id)
		validar_solapamiento_de_eventos(nuevo_evento)
		@evento[nuevo_evento.id] = nuevo_evento
	end
		
	def eliminarEventoDelCalendario(id)
		@evento.delete[id]
	end
		
	def getEvento(id)
		return @evento[id] == id

	end	

	def getTotalDeEventos()
		return @evento.size()

	end


	def actualizarEvento(id, inicio, fin)
		@evento.getEvento(id)
		@evento.actualizarEvento(inicio, fin)
	end

	def validar_unico_evento_del_calendario(id)
		raise ExceptionUnicoEvento if @evento[id] == id

	end	



	def validar_solapamiento_de_eventos(nuevo_evento)
		hora_inicio = Date.parse(nuevo_evento.inicio)
		hora_fin = Date.parse(nuevo_evento.fin)
		@evento.values.each do |e|
			inicio_comparar = Date.parse(e.inicio)
			fin_comparar = Date.parse(e.fin)
			raise ExceptionLosEventosSeSolapan if hora_inicio.between?(inicio_comparar, fin_comparar) && e.id != id
			raise ExceptionLosEventosSeSolapan if hora_fin.between?(inicio_comparar, fin_comparar) && e.id != id
			raise ExceptionLosEventosSeSolapan if inicio_comparar.between?(hora_inicio, hora_fin) && e.id != id
			raise ExceptionLosEventosSeSolapan if fin_comparar.between?(hora_inicio, hora_fin) && e.id != id
		end
	end	
	

end