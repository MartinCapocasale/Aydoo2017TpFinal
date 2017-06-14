require_relative '../model/frecuencia'

class FrecuenciaSemanal < Frecuencia
	
	SEMANA = 7  	

  	def initialize()
   		 @frecuencia = SEMANA
	end
end	