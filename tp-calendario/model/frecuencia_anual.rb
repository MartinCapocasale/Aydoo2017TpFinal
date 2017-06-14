require_relative '../model/frecuencia'

class FrecuenciaAnual < Frecuencia
	
	ANIO = 365  	

  	def initialize()
   		 @frecuencia = ANIO
	end
end	