require 'rspec'
require_relative '../model/evento'


describe 'Evento' do 

	before do
    	@evento = Evento.new "05", "Reunion","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO", "CalendarioDeTrabajo"
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

end	