require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

	let (:calendario) {Calendario.new('CalendarioDeExamenes')}

	it 'Creo un calendario de examenes ' do
		expect(calendario.nombre).to eq 'CalendarioDeExamenes'
	end

end