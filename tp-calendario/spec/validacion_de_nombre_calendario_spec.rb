require 'rspec'
require_relative '../model/validacion_de_nombre_calendario'
require_relative '../model/calendario'


describe 'Validacion_de_nombre_calendario' do 

	it 'no es posible crear un calendario sin nombre' do
	  expect{Calendario.new nil }.to raise_error(ExceptionValidacionDeNombreCalendario)
	end
end	