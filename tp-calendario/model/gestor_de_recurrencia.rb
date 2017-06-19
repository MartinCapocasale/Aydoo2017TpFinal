require_relative '../model/evento'


class GestorDeRecurrencia < Evento

	attr_accessor :frecuencia
	attr_accessor :fechaFin	
	
	def initialize(nombre_calendario, id, nombre, inicio, fin, recurrencia, frecuencia, fin_recurrencia)
	    super(nombre_calendario, id, nombre, inicio, fin, recurrencia)
	    
	    @frecuencia = frecuencia
	    @fechaFin = fin_recurrencia
	end

    def obtener_intervalo
      intervalos = []
      inicio = @inicio
      fin = @fin
      while inicio <= @fechaFin do
      	intervalos << (inicio..fin)
      	inicio += @frecuencia.obtener_frecuencia
      	fin += @frecuencia.obtener_frecuencia
      end
    intervalos
    end

	def obtener_frecuencia
	  	return @frecuencia
	end

    def obtener_fecha_fin
	    return @fechaFin
	end

	

end