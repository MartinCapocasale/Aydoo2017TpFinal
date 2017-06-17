require_relative '../model/frecuencia'
require 'date'

class FrecuenciaSemanal 
	
	SEMANA = 7  	
 	
 	def calcular(una_fecha)
   		 nueva_fecha = una_fecha.next_day(SEMANA)
   		 return nueva_fecha
	end
end	