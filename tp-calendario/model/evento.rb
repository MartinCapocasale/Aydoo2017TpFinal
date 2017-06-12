class Evento
	attr_reader :nombre
	attr_reader :id
	attr_accessor :incio
	attr_accessor :fin
	attr_accessor :incio
	attr_accessor :recurrencia


	def initialize(id, nombre, inicio, fin, recurrencia)
		@incio = incio
		@nombre = nombre
		@fin = fin
		@id = id
		@recurrencia = recurrencia
	end

	def validar_tiempo(inicio, fin)

	end	


end	
