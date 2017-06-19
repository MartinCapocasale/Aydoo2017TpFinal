require_relative './validacion_de_duracion'
require_relative './frecuencia'
require "date"

class Evento
	attr_reader :nombre_calendario
	attr_reader :id
	attr_reader :nombre
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :recurrencia
	attr_accessor :frecuencia
	attr_accessor :json_del_evento
	

	def initialize(nombre_calendario, id, nombre, inicio, fin)
	  #cambiar esto a snake case
	  ValidacionDeDuracion.new(inicio, fin) unless (!inicio || !fin) 
 	  @nombre_calendario = nombre_calendario
	  @id = id
	  @nombre = nombre
	  @inicio = inicio
	  @fin = fin
	  @recurrencia = recurrencia
	  @json_del_evento = {'calendario' => @nombre_calendario, 'id' => @id, 'nombre' => @nombre, 'inicio' => @inicio, 'fin' => @fin}
	end

	def mostrar_contenido()
	  return JSON[@json_del_evento]
	end

	def actualizar_evento(nuevo_evento)
	  #establezco nuevo inicio con la fecha actual del evento por si no hace falta modificarla
	  inicio_nuevo = get_fecha_inicio()
	  #establezco nuevo fin con la fecha actual del evento por si no hace falta modificarla
	  fin_nuevo = get_fecha_fin()
	  #establezco nuevo inicio con la fecha del evento nuevo, si existe nueva fecha para modificar
	  inicio_nuevo = nuevo_evento.get_fecha_inicio() unless !nuevo_evento.get_fecha_inicio()
	  #establezco nuevo fin con la fecha del evento nuevo, si existe nueva fecha para modificar
	  fin_nuevo = nuevo_evento.get_fecha_fin() unless !nuevo_evento.get_fecha_fin()
	  if (ValidacionDeDuracion.new(inicio_nuevo, fin_nuevo))
	  	#actualizo fecha de inicio
	  	@inicio = inicio_nuevo
	  	#actualizo fecha de fin
	  	@fin = fin_nuevo
	  	#actualizo el json del evento con todos sus datos
	  	@json_del_evento = {'calendario' => @nombre_calendario, 'id' => @id, 'nombre' => @nombre, 'inicio' => @inicio, 'fin' => @fin}
	  end
	  return mostrar_contenido()
	end

	def get_fecha_inicio()
	  return @inicio
	end

	def get_fecha_fin()
	  return @fin
	end

	#cambiar todos los metodos camel case a snake case
	def setInicio(inicioNuevo)
	  ValidacionDeDuracion.new(inicioNuevo, @fin)
	  @inicio = inicioNuevo
	end

	def setFin(finNuevo)
	  ValidacionDeDuracion.new(@inicio, finNuevo)
	  @fin = finNuevo
	end
end	
