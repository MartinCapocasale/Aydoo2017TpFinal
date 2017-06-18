require_relative './exception_validacion_de_duracion'
require 'date'


class ValidacionDeDuracion

	MAXIMA_DURACION = 72
	HORAS = (1/24.0)

	def initialize(inicio, fin)
		raise ExceptionValidacionDeDuracion  if (fin < inicio)
		hora_inicio  = DateTime.parse(inicio)
		hora_fin  = DateTime.parse(fin)
			
		intervalo = ((hora_fin - hora_inicio) / HORAS)

    	raise ExceptionValidacionDeDuracion  unless (intervalo < MAXIMA_DURACION)
    	
  	end

end 	

