require 'rspec' 
require_relative '../model/frecuencia_semanal'

describe 'FrecuenciaSemanal' do

	before do
	    @una_frecuencia = FrecuenciaSemanal.new 
	end

	it 'deberia devolver "2017-03-14T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("2017-03-7T18:00:00-03:00")
	    valor_esperado = DateTime.new(2017, 3, 14, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	   
	    expect(valor_obtenido).to eq(valor_esperado)
	end

	it 'deberia devolver "2017-01-07T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("2016-12-31T18:00:00-03:00")
	    valor_esperado = DateTime.new(2017, 1, 7, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	    
	    expect(valor_obtenido).to eq(valor_esperado)
	end
end