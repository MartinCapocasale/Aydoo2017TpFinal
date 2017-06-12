require 'rspec'
require_relative '../model/evento'


describe 'Evento' do 

	before do
    	@evento = Evento.new "1", "Reunion","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO"
  	end


	it  'es posible crear un evento con nombre Reunion ' do
		valor_esperado = "Reunion"
  		valor_obtenido = @evento.nombre
		expect(valor_obtenido).to eq(valor_esperado)
	end	



end	