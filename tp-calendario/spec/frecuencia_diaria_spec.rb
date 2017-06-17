require 'rspec' 
require_relative '../model/frecuencia_diaria'


describe 'FrecuenciaDiaria' do

	before do
	    @una_frecuencia = FrecuenciaDiaria.new 
	end

	it 'deberia devolver "2017-03-5T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("2017-03-4T18:00:00-03:00")
	    valor_esperado = DateTime.new(2017, 3, 5, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	   
	    expect(valor_obtenido).to eq(valor_esperado)
	end

	it 'deberia devolver "2000-01-01T18:00:00-03:00"' do
	    fecha_inicio = DateTime.parse("1999-12-31T18:00:00-03:00")
	    valor_esperado = DateTime.new(2000, 1, 1, 18, 0, 0, "-03:00") 
	    valor_obtenido = @una_frecuencia.calcular(fecha_inicio)
	    
	    expect(valor_obtenido).to eq(valor_esperado)
	end

end