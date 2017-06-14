require 'sinatra'
require 'json'
require_relative './model/archivo.rb'
require_relative './model/evento.rb'

post '/calendarios' do
  #paso json ingresado por usuario a variable
  params = JSON.parse(request.body.read)
  #nombre de archivo que tiene la lista de calendarios
  nombre_archivo_lista_calendarios = 'lista_de_calendarios'
  #tomo de parametros ingresados el nombre del calendario a crear
  nombre_calendario_a_crear = params['nombre']
  #creo un nuevo objeto archivo que voy a utilizar
  calendario_nuevo = Archivo.new
  #creo un nuevo objeto archivo que voy a utilizar
  lista_de_calendarios = Archivo.new
  #si existen los parametros pasados por usuario y si no existe ya el calendario en la lista
  if (!params.nil? && !calendario_nuevo.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_crear))
    #agrego nuevo calendario dentro de la lista de calendarios
    lista_de_calendarios.escribir(nombre_archivo_lista_calendarios, nombre_calendario_a_crear)
    #creo el nuevo archivo con el nuevo nombre recibido por json
    calendario_nuevo.crear_y_escribir(nombre_calendario_a_crear,'')
    #devuelvo status
    status 201
  else
    #devuelvo status
    status 400
  end
end

get '/calendarios' do
    #nombre de archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    lista_de_calendarios = Archivo.new
    texto_a_mostrar = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #devuelvo status
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
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end


post '/eventos' do
  params = JSON.parse(request.body.read)
  if (!params.nil?)
    #creo nuevo evento con los parametros de json
    nuevo_evento = Evento.new params['calendario'],params['id'], params['nombre'], params['inicio'], params['fin'], params['recurrencia']
    #guardo el nombre del calendario donde se quiere crear el evento
    nombre_calendario_a_crear = params['calendario']
    archivo = Archivo.new
    #abre el archivo calendario con el nombre recibido por json
    archivo.escribir(nombre_calendario_a_crear,nuevo_evento.mostrar_contenido())
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end
