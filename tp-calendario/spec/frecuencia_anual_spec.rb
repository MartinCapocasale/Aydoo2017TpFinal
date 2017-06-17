require 'rspec' 
require_relative '../model/frecuencia_anual'

describe 'FrecuenciaAnual' do

	before do
	    @una_frecuencia = FrecuenciaAnual.new 
	end

	it 'deberia devolver "2018-03-14T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("2017-03-14T18:00:00-03:00")
	    valor_esperado = DateTime.new(2018, 3, 14, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	   
	    expect(valor_obtenido).to eq(valor_esperado)
	end

	it 'deberia devolver "2017-12-30T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("2016-12-30T18:00:00-03:00")
	    valor_esperado = DateTime.new(2017, 12, 30, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	    
	    expect(valor_obtenido).to eq(valor_esperado)
	end
end