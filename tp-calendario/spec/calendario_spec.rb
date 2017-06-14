require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/evento'



describe 'Calendario' do

	let (:calendario) {Calendario.new('CalendarioDeExamenes')}
	

	it 'Creo un calendario de examenes ' do
		expect(calendario.nombre).to eq 'CalendarioDeExamenes'
	end


	it 'es posible agregar un evento al calendario ' do
		evento = Evento.new "1", "ParcialA","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO", "CalendarioDeExamenes"
	  	calendario.agregarEventoAlCalendario(evento)
	 	expect(calendario.evento.size).to eq 1	
	end 


=begin
	it 'es posible agregar mas de un evento al calendario ' do
		evento1 = Evento.new "1", "ParcialA","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO", "CalendarioDeExamenes"
		evento2 = Evento.new "2", "ParcialB","2017-04-24T15:00:00-03:00","2017-04-25T16:00:00-03:00", "NO", "CalendarioDeExamenes"
	  	calendario.agregarEventoAlCalendario(evento1)
	  	calendario.agregarEventoAlCalendario(evento2)
	 	expect(calendario.evento1.size + calendario.evento2.size).to eq 2	
	end
=end


end