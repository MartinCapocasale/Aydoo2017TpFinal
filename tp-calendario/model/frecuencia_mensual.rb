require_relative '../model/frecuencia'
require 'date'

class FrecuenciaMensual
	
	MES = 1  	

   	def calcular(una_fecha)
   		nueva_fecha = una_fecha.next_month(MES)
   		return nueva_fecha
	end
end	