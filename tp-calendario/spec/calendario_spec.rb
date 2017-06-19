require 'rspec'
require_relative '../model/calendario'

describe 'Calendario' do

	let (:calendario) { Calendario.new }

	it 'guardo un texto en un archivo nuevo, el resultado de leerlo debe ser el texto guardado' do
		calendario.crear_y_escribir("prueba.txt", "texto de prueba")
		expect(calendario.leer("prueba.txt")).to eq "texto de prueba\n"
	end

end