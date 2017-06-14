require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/evento'


describe 'Calendario' do

	let (:calendario) {Calendario.new('CalendarioDeExamenes')}
	let (:validador) {Validacion_de_duracion.new()}

	it 'Creo un calendario de examenes ' do
		expect(calendario.nombre).to eq 'CalendarioDeExamenes'
	end


	it 'es posible agregar un evento al calendario ' do
		evento = Evento.new "1", "Reunion","2017-04-20T15:00:00-03:00","2017-04-20T16:00:00-03:00", "NO", "CalendarioDeExamenes"
	  	calendario.agregarEventoAlCalendario(evento)
	 	expect(calendario.evento.size).to eq 1	
	end 	

end