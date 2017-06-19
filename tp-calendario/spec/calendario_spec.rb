require 'rspec'
require 'json'
require_relative '../model/calendario'

describe 'Calendario' do

	let (:calendario) { Calendario.new }

	it 'guardo un texto en un archivo nuevo, el resultado de leerlo debe ser el texto guardado' do
		calendario.crear_y_escribir("prueba.txt", "texto de prueba")
		expect(calendario.leer("prueba.txt")).to eq "texto de prueba\n"
	end

	it 'verifico que exista texto dentro de archivo archivo prueba.txt. si existe devuelve true' do
		expect(calendario.verificar_si_existe("prueba.txt", "texto de prueba")).to eq true
	end

	it 'creo calendario pepito y verifico que exista. si existe devuelve true' do
		json = {'nombre' => 'pepito'}
		nombre_archivo_lista_calendarios = "lista_de_calendarios"
		calendario.crear_nuevo_calendario(json)
		expect(calendario.verificar_si_existe(nombre_archivo_lista_calendarios, "pepito")).to eq true
	end

	it 'elimino el calendario recien creado y verifico que no exista. si no existe devuelve false' do
		params = {:nombre => 'pepito'}
		nombre_archivo_lista_calendarios = "lista_de_calendarios"
		calendario.eliminar_calendario(params)
		expect(calendario.verificar_si_existe(nombre_archivo_lista_calendarios, "pepito")).to eq false
	end

	it 'busco calendario pepito por su nombre. si no existe devuelve string'' ' do
		params = {:nombre => 'pepito'}
		expect(calendario.buscar_calendario_por_su_nombre(params)).to eq ''
	end

	it 'creo calendario pepito y verifico que exista. si se crea con exito devuelve 201' do
		json = {'nombre' => 'pepito'}
		expect(calendario.crear_nuevo_calendario(json)).to eq 201
	end

	it 'agrego un nuevo evento. si se crea con exito devuelve 200' do
		#params = {:calendario => 'pepito', :id => 'evento1', :nombre => 'evento uno', :inicio => '2017-07-30T18:00:00-03:00', :fin => '2017-07-30T19:00:00-03:00'}
		#params = {"calendario":"pepito", "id":"evento1", "nombre":"evento uno", "inicio":"2017-07-30T18:00:00-03:00", "fin":"2017-07-30T19:00:00-03:00"}
		params = {"calendario" => 'pepito', "id" => 'id_pepito', "nombre" => 'evento uno', "inicio" => '2017-07-30T18:00:00-03:00', "fin" => '2017-07-30T19:00:00-03:00'}
		expect(calendario.agregar_un_evento(params)).to eq 200
	end

	it 'busco por su ID al evento recien creado. si lo encuentra resultado debe ser 200' do
		params = {:id => 'id_pepito'}
		expect(calendario.status_de_mostrar_evento_segun_id(params)).to eq 200
	end

	it 'envio el ID de un evento inexistente a eliminar. no debe encontrarlo y el resultado debe ser 400' do
		params = {:id => 'id_inexistente'}
		expect(calendario.eliminar_evento_por_id(params)).to eq 400
	end

	it 'envio el ID del evento a eliminar. si lo encuentra debe borrarlo y el resultado debe ser 200' do
		params = {:id => 'id_pepito'}
		expect(calendario.eliminar_evento_por_id(params)).to eq 200
	end

	it 'elimino el calendario recien creado y verifico que no exista. si no existe devuelve false' do
		params = {:nombre => 'pepito'}
		expect(calendario.eliminar_calendario(params)).to eq 200
	end

end
