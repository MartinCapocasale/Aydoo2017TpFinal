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
  nombre_calendario_a_crear = params['nombre'].downcase
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
    #creo un nuevo objeto archivo que voy a utilizar
    lista_de_calendarios = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    texto_a_mostrar = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #convierto el texto a json, esto tiene que ir en un presentador
    json_a_devolver = ''
    texto_a_mostrar.each_line { |line|
      json_a_devolver = {'nombre' => line.chomp}
    }
    #devuelvo status
    status 200
    #muestra lista de calendarios
    body JSON[json_a_devolver]
end

delete '/calendarios/:nombre' do
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_calendario_a_eliminar = params[:nombre].downcase
  if (!nombre_calendario_a_eliminar.nil?)
    #creo un nuevo objeto archivo que voy a utilizar
    archivo = Archivo.new
    #borro el archivo del calendario indicado por el usuario
    archivo.borrar_archivo(nombre_calendario_a_eliminar)
    #creo un nuevo objeto archivo que voy a utilizar
    actualizar_lista_calendarios = Archivo.new
    #nombre de archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #busco el calendario en la lista y lo elimino
    actualizar_lista_calendarios.busca_contenido_y_elimina(nombre_archivo_lista_calendarios, nombre_calendario_a_eliminar)
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end

get '/calendarios/:nombre' do
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_calendario_a_mostrar = params[:nombre].downcase
  #nombre de archivo que tiene la lista de calendarios
  nombre_archivo_lista_calendarios = 'lista_de_calendarios'
  #creo un nuevo objeto archivo que voy a utilizar
  calendario_a_buscar = Archivo.new
  if (!nombre_calendario_a_mostrar.nil? & calendario_a_buscar.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
    #preparo el json con el nombre del calendario, ya verificada su existencia
    json_a_devolver = {'nombre' => nombre_calendario_a_mostrar}
    #devuelvo status
    status 200
    #muestra el calendario como json
    body JSON[json_a_devolver]
  else
    #devuelvo status
    status 400
  end
end

post '/eventos' do
  #paso json ingresado por usuario a variable
  params = JSON.parse(request.body.read)
  #guardo el nombre del calendario donde se quiere crear el evento
  nombre_calendario_a_modificar = params['calendario'].downcase
  #creo un nuevo objeto archivo que voy a utilizar  
  archivo = Archivo.new
  if (!params.nil?)
    #creo nuevo evento con los parametros de json
    nuevo_evento = Evento.new params['calendario'].downcase,params['id'], params['nombre'], params['inicio'], params['fin'], params['recurrencia']
    #abro el archivo calendario con el nombre recibido por json y guardo el evento
    archivo.escribir(nombre_calendario_a_modificar,nuevo_evento.mostrar_contenido())
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end

get '/eventos' do
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_calendario_a_mostrar = params[:calendario].downcase
  #nombre de archivo que tiene la lista de calendarios
  nombre_archivo_lista_calendarios = 'lista_de_calendarios'
  #creo un nuevo objeto archivo que voy a utilizar
  calendario_a_buscar = Archivo.new
  if (!nombre_calendario_a_mostrar.nil? & calendario_a_buscar.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
    #creo un nuevo objeto archivo que voy a utilizar
    lista_de_eventos = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    texto_a_mostrar = lista_de_eventos.leer(nombre_calendario_a_mostrar)
    #devuelvo status
    status 200
    #muestra lista de calendarios
    body texto_a_mostrar
  else
    #devuelvo status
    status 400
  end
end
