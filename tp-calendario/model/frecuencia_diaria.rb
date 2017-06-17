require_relative '../model/frecuencia'
require 'date'

class FrecuenciaDiaria 
	
	DIA = 1  	

  	def calcular(una_fecha)
   		 nueva_fecha = una_fecha.next_day(DIA)
   		 return nueva_fecha
	end
end	