require_relative './frecuencia_diaria'
require_relative './frecuencia_semanal'
require_relative './frecuencia_mensual'
require_relative './frecuencia_anual'

class Frecuencia
	attr_reader :frecuencia
	

	def initialize(frecuencia)
   	 	@frecuencia = frecuencia
    	
 	end

 	def self.tiposDeRecurrencia =
				{"diaria"=> FrecuenciaDiaria.new, 
    	         "semanal" => FrecuenciaSemanal.new,
    	         "mensual" => FrecuenciaMensual.new,
				 "anual" => FrecuenciaAnual.new
				}
    end

    def set_Frecuencia(frecuencia)
    	 self.tiposDeRecurrencia[frecuencia]
    end	 

end