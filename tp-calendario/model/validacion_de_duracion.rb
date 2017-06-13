require_relative './exception_validacion_de_duracion'
require 'date'


class ValidacionDeDuracion

	def initialize(inicio, fin)
		hora_inicio  = Date.parse(inicio)
		hora_fin  = Date.parse(fin)
		intervalo = ((hora_fin - hora_inicio)*24)
    	if(intervalo > 0.72)
    		raise ExceptionValidacionDeDuracion 
  		end
  	end

end 	