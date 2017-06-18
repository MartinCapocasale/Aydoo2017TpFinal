require 'rspec'
require 'date'
require_relative '../model/evento'
require_relative '../model/gestor_de_recurrencia'


describe 'Evento' do 

	before do
    	@evento = Evento.new "CalendarioDeTrabajo", "05", "Reunion","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO"
  		@evento1 = Evento.new "CalendarioDeTrabajo", "1", "Reunion","2017-03-01T18:00:00-03:00","2017-03-01T20:00:00-03:00", "diaria"
  	end


	it  'es posible crear un evento con id=05 ' do
		valor_esperado = "05"
  		valor_obtenido = @evento.id
		expect(valor_obtenido).to eq(valor_esperado)
	end	

	it  'es posible crear un evento con nombre Reunion ' do
	valor_esperado = "Reunion"
  	valor_obtenido = @evento.nombre
	expect(valor_obtenido).to eq(valor_esperado)

	end	

	it  'es posible crear un evento sin recurrencia ' do
	valor_esperado = "NO"
  	valor_obtenido = @evento.recurrencia
	expect(valor_obtenido).to eq(valor_esperado)
	
	end	

	it  'es posible crear un evento con inicio 2017-04-20T15:00:00-03:00 ' do
	valor_esperado = "2017-04-20T15:00:00-03:00"
  	valor_obtenido = @evento.inicio
	expect(valor_obtenido).to eq(valor_esperado)
	
	end	

	it  'es posible crear un evento con fin 2017-04-20T16:00:00-03:00 ' do
	valor_esperado = "2017-04-20T16:00:00-03:00"
  	valor_obtenido = @evento.fin
	expect(valor_obtenido).to eq(valor_esperado)
	
	end	

	it  'es posible crear un evento en el CalendarioDeTrabajo ' do
	valor_esperado = "CalendarioDeTrabajo"
  	valor_obtenido = @evento.nombre_calendario
	expect(valor_obtenido).to eq(valor_esperado)
	
	end	
=begin
	it  'es posible crear un evento con frecuencia diaria' do
		fecha_fin = "2017-03-3T20:00:00-03:00"
		recurrencia = GestorDeRecurrencia.new("diaria", fecha_fin)
		@evento1.calcular_recurrencia(recurrencia)
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


