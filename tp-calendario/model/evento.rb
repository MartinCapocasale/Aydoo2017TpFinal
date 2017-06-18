require_relative './validacion_de_duracion'
require_relative './gestor_de_recurrencia'
require_relative './frecuencia'
require "date"

class Evento
	attr_accessor :nombre_calendario
	attr_accessor :id
	attr_accessor :nombre
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :recurrencia
	attr_accessor :nuevo_evento
	attr_accessor :frecuencia
	attr_accessor :json_del_evento
	

	def initialize(nombre_calendario, id, nombre, inicio, fin, recurrencia)
		ValidacionDeDuracion.new(inicio, fin)
		@nombre_calendario = nombre_calendario
		@id = id
		@nombre = nombre
		@inicio = inicio
		@fin = fin
		@recurrencia = recurrencia
		@nuevo_evento = []
		@frecuencia = Frecuencia.new
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

	def calcular_recurrencia(gestor_de_recurrencia)
		una_frecuencia = @frecuencia.set_Frecuencia(gestor_de_recurrencia.obtener_frecuencia)
		fechaFin = gestor_de_recurrencia.obtener_fecha_fin
		fechaActual = @inicio
		hora_ini = @inicio
		hora_fin = @fin
		i = 0
    	j = 1
   	    while fechaActual <= fechaFin do
   	    	@nuevo_evento[i] = fechaActual
   	    	@nuevo_evento = hora_fin
   	    	fechaActual = una_frecuencia.calcular(fechaActual)
   	    	hora_fin = una_frecuencia.calcular(hora_fin)
   	    	i = i + 2
   	    	j = j + 2
   	    end
	end

	def obtenerEvento
		return @nuevo_evento
	end
end	
