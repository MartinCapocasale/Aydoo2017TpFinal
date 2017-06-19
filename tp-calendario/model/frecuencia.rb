class Frecuencia
	
	attr_accessor :tiposDeRecurrencia

	def initialize()
   	    @tiposDeRecurrencia = {"diaria" => FrecuenciaDiaria.new, 
                              "semanal" => FrecuenciaSemanal.new,
                              "mensual" => FrecuenciaMensual.new,
                              "anual" => FrecuenciaAnual.new
                             }
    end


    def set_Frecuencia(frecuencia)
    	 return @tiposDeRecurrencia[frecuencia]
    end	 

end