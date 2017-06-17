require_relative '../model/frecuencia'
require 'date'

class FrecuenciaAnual 

	ANIO = 1  	

  	def calcular(una_fecha)
   		nueva_fecha = una_fecha.next_year(ANIO)
   		return nueva_fecha
	end
end	