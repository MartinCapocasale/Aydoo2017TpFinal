require_relative './model/calendario'

class Evento
	attr_reader : nombre
	attr_reader : id
	attr_accessor : incio
	attr_accessor : fin
	attr_accessor : incio
	attr_accessor : calendario
	attr_accessor : recurrencia


	def initialize (calendario, id, nombre, inicio, fin, recurrencia)
		validar_duracion(inicio, fin)
		@incio = incio
		@fin = fin
		@calendario = calendario
		@id = id
		@recurrencia = recurrencia
	end

	def validar_duracion(inicio , fin)
		
	end


end	
