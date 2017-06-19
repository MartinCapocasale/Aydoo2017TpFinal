require 'rspec'
require 'date'
require_relative '../model/evento'
require_relative '../model/gestor_de_recurrencia'

describe 'Evento' do 

	before do
    	@evento = Evento.new "CalendarioDeTrabajo", "05", "Reunion","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00"
  		@evento1 = Evento.new "CalendarioDeTrabajo", "1", "Reunion","2017-03-01T18:00:00-03:00","2017-03-01T20:00:00-03:00" 
  	end
=begin

	it  'es posible crear un evento con frecuencia diaria' do
		fecha_fin = "2017-03-3T20:00:00-03:00"
		recurrencia = GestorDeRecurrencia.new("diaria", fecha_fin)
		recurrencia.calcular_recurrencia(recurrencia)
		fecha1 = DateTime.parse("2017-03-01T18:00:00-03:00")
	    fecha2 = DateTime.parse("2017-03-02T18:00:00-03:00")
	    fecha3 = DateTime.parse("2017-03-03T18:00:00-03:00")
	    fecha4 = DateTime.parse("2017-03-01T20:00:00-03:00")
	    fecha5 = DateTime.parse("2017-03-02T20:00:00-03:00")
	    fecha6 = DateTime.parse("2017-03-03T20:00:00-03:00")

	    valor_esperado = [fecha1, fecha4, fecha2, fecha5, fecha3, fecha6]
		valor_obtenido = @evento1.obtenerEvento
		expect(valor_obtenido).to eq(valor_esperado)
	end
=end

end