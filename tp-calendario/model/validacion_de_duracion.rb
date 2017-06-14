require_relative './exception_validacion_de_duracion'
require 'date'


class ValidacionDeDuracion

	MAXIMA_DURACION = 72
	HORAS = 24

	def initialize(inicio, fin)
		hora_inicio  = Date.parse(inicio)
		hora_fin  = Date.parse(fin)
		intervalo = ((hora_fin - hora_inicio)* HORAS)
    	if(!(intervalo < MAXIMA_DURACION))
    		raise ExceptionValidacionDeDuracion 
  		end
  	end

end 	