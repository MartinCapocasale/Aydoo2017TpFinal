class Frecuencia
	
	attr_accessor :tiposDeRecurrencia

	def initialize()
   	    @tiposDeRecurrencia = {"diaria"=> FrecuenciaDiaria.new, 
                              "semanal" => FrecuenciaSemanal.new,
                              "mensual" => FrecuenciaMensual.new,
                              "anual" => FrecuenciaAnual.new
                             }
    end


    def set_Frecuencia(frecuencia)
    	 self.tiposDeRecurrencia[frecuencia]
    end	 

end