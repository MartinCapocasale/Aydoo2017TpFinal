require 'sinatra'
require 'json'
require_relative './model/archivo.rb'
require_relative './model/evento.rb'

post '/calendarios' do
  params = JSON.parse(request.body.read)
  ##body "Muestro el JSON: #{params['nombre'].inspect}"
  if (!params.nil?)
    nombre_calendario_a_crear = params['nombre'].downcase
    #nombre de archivo guarda el nombre del archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    lista_de_calendarios = Archivo.new
    #agrego nuevo calendario dentro de la lista de calendarios
    lista_de_calendarios.escribir(nombre_archivo_lista_calendarios, nombre_calendario_a_crear)
    archivo = Archivo.new
    #creo el nuevo archivo con el nuevo nombre recibido por json
    archivo.crear_y_escribir(nombre_calendario_a_crear,'nuevo')
    ##texto_a_mostrar = archivo.leer(nombre_calendario)
    status 201
    ##body texto_a_mostrar
  else
    status 400
    ##body "400 Bad Request"
  end
end

get '/calendarios' do
    #nombre de archivo guarda el nombre del archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    lista_de_calendarios = Archivo.new
    texto_a_mostrar = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    status 200
    #muestra lista de calendarios
    body texto_a_mostrar
end

delete '/calendarios/:nombre' do
  nombre_calendario_a_eliminar = params[:nombre].downcase
  if (!nombre_calendario_a_eliminar.nil?)
    archivo = Archivo.new
    archivo.borrar_archivo(nombre_calendario_a_eliminar)
    actualizar_lista_calendarios = Archivo.new
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    actualizar_lista_calendarios.busca_contenido_y_elimina(nombre_archivo_lista_calendarios, nombre_calendario_a_eliminar)
    status 200
  else
    status 400
    ##body "400 Bad Request"
  end
end


post '/eventos' do
  params = JSON.parse(request.body.read)
  ##body "Muestro el JSON: #{params['nombre'].inspect}"
  if (!params.nil?)
    #crea el evento con los parametros de json
    nuevo_evento = Evento.new params['calendario'],params['id'], params['nombre'], params['inicio'], params['fin'], params['recurrencia']
    archivo = Archivo.new
    #abre el archivo calendario con el nombre recibido por json
    archivo.escribir(nombre_calendario_a_crear,nuevo_evento)
    status 200
    body nuevo_evento.mostrar_contenido()
  else
    status 400
    ##body "400 Bad Request"
  end
end

=begin    
    nombre_calendario_a_crear = params['nombre']
    #nombre de archivo guarda el nombre del archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    lista_de_calendarios = Archivo.new
    #agrego nuevo calendario dentro de la lista de calendarios
    lista_de_calendarios.escribir(nombre_archivo_lista_calendarios, nombre_calendario_a_crear)
    archivo = Archivo.new
    #creo el nuevo archivo con el nuevo nombre recibido por json
    archivo.crear_y_escribir(nombre_calendario_a_crear,'nuevo')
    ##texto_a_mostrar = archivo.leer(nombre_calendario)
    status 201
=end

=begin
get '/calendarios' do
  params = JSON.parse(request.body.read)["mensajes"]
  if (!params.nil?)
    nombre_calendario = params['nombre']
    archivo = Archivo.new
    texto_a_mostrar = archivo.leer(nombre_calendario)
    status 200
    body texto_a_mostrar
  else
    status 400
    body "400 Bad Request"
  end
end
=end

=begin
get '/calendario/:nombre_calendario' do
  parametros = params[:nombre_calendario]
  if (!parametros.nil?)
    nombre_calendario = parametros
    archivo = Archivo.new
    texto_a_mostrar = archivo.leer(nombre_calendario)
    status 200
    body texto_a_mostrar
  else
    status 400
    body "400 Bad Request"
  end
end

post '/calendarios' do
  push = JSON.parse(request.body.read)
  body "Muestro el JSON: #{push.inspect}"
end
=end

=begin
post'/calendarios' do
	{
  	"nombre":"calendario1" 
	}
	status=201
	status=400 (si el nombres esta duplicado o nombre vacio)
end

delete '/calendarios/calendario1' do
	status=200
	status=404 (no encontrado)
end

get '/calendarios' do
	status=200
	[
  	{
    "nombre":"calendario1"
  	},
  	{
    "nombre":"calendario2"
  	}
	]
end

get '/calendarios/calendario1' do
	{
  	"nombre":"calendario1"
	}
	status = 200
	status = 404 (si no existe)
end

post '/eventos' do
	{
  	"calendario":"untref",
  	"id":"unico-global"
  	"nombre":"aydoo",
  	"inicio": "2017-03-31T18:00:00-03:00",
  	"fin": "2017-03-31T22:00:00-03:00",
  	"recurrencia": {
    "frecuencia": "semanal",
    "fin":"2017-06-28"
  	}
	}
	status=201
	status=400 (si hay un error de validación)
end

put'/eventos' do
	{
  	"calendario":"untref", # no puede cambiar
  	"nombre":"aydoo", # no cambia
  	"inicio": "2017-03-31T18:00:00-03:00",
  	"fin": "2017-03-31T22:00:00-03:00",
	}

delete '/eventos/ID' do

end


get '/eventos' do

end	


get '/eventos?calendario=calendario1' do

end	

get '/eventos/ID' do

end
=end