require_relative './validacion_de_duracion'

class Evento
	attr_accessor :nombre_calendario
	attr_accessor :id
	attr_accessor :nombre
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :recurrencia
	attr_accessor :nuevo_evento
	
	

	def initialize(nombre_calendario, id, nombre, inicio, fin, recurrencia)
		#ValidacionDeDuracion.new(inicio, fin)
		@nombre_calendario = nombre_calendario
		@id = id
		@nombre = nombre
		@inicio = inicio
		@fin = fin
		@recurrencia = recurrencia
		@nuevo_evento = Array.new
		@json_del_evento = {'calendario' => @nombre_calendario, 'id' => @id, 'nombre' => @nombre, 'inicio' => @inicio, 'fin' => @fin}
	end

	def mostrar_contenido()
		return JSON[@json_del_evento]
	end

	def actualizarEvento(inicioNuevo, finNuevo)
		ValidacionDeDuracion.new(inicioNuevo, finNuevo)
		@inicio = inicioNuevo
		@fin = finNuevo
	end

	def setInicio(inicioNuevo)
		ValidacionDeDuracion.new(inicioNuevo, @fin)
		@inicio = inicioNuevo
	end

	def setFin(finNuevo)
		ValidacionDeDuracion.new(@inicio, finNuevo)
		@fin = finNuevo
	end	

end	
