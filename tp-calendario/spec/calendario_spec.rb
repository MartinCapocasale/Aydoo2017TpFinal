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
	 	expect(calendario.getTotalDeEventos).to eq 1	
	end 



	it 'es posible agregar mas de un evento al calendario ' do
		evento1 = Evento.new "1", "ParcialA","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO", "CalendarioDeExamenes"
		evento2 = Evento.new "2", "ParcialB","2017-04-24T15:00:00-03:00","2017-04-25T16:00:00-03:00", "NO", "CalendarioDeExamenes"
	  	calendario.agregarEventoAlCalendario(evento1)
	  	calendario.agregarEventoAlCalendario(evento2)
	 	expect(calendario.getTotalDeEventos).to eq 2	
	end
=begin
	it 'no es posible crear dos eventos superpuestos' do

	    Evento.new  "1", "Un evento", "2017-03-31T16:00:00-03:00", "2017-03-31T17:30:00-03:00", "NO","CalendarioDeExamenes"
    	expect {Evento.new "2", "Otro evento", "2017-03-31T17:00:00-03:00", "2017-03-31T18:00:00-03:00","NO", "CalendarioDeExamenes"}.to raise_error(ExceptionLosEventosSeSolapan)
	end
=end	

end