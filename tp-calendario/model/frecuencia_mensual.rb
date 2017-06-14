require_relative '../model/frecuencia'

class FrecuenciaMensual < Frecuencia
	
	MES = 30  	

  	def initialize()
   		 @frecuencia = MES
	end
end	