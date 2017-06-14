require 'rspec'
require_relative '../model/validacion_de_duracion'
require_relative '../model/evento'
require 'date'


describe 'Validacion_de_duracion' do 

	it 'no es posible validar un evento de mas de 72 horas' do
  		expect{ValidacionDeDuracion.new "2017-01-28T17:00:00-03:00", "2017-01-31T18:00:00-03:00"}.to raise_error(ExceptionValidacionDeDuracion)
	end

	it 'no es posible validar un evento con fin menor que incio' do
  		expect{ValidacionDeDuracion.new "2017-01-28T19:00:00-03:00", "2017-01-31T18:00:00-03:00"}.to raise_error(ExceptionValidacionDeDuracion)
	end


end	