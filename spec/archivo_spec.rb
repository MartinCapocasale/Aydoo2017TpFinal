require 'rspec'
require_relative '../model/archivo'

describe 'Archivo' do

	let (:archivo) { Archivo.new }

	it 'guardo un texto en un archivo nuevo, el resultado de leerlo debe ser el texto guardado' do
		archivo.crear_y_escribir("prueba.txt", "texto de prueba")
		expect(archivo.leer("prueba.txt")).to eq "texto de prueba\n"
	end

end