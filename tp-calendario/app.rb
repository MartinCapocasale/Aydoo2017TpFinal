require 'sinatra'
require 'json'
require_relative './model/archivo.rb'
require_relative './model/evento.rb'
#defino el nombre de archivo que tiene la lista de calendarios
nombre_archivo_lista_calendarios = 'lista_de_calendarios'
#creo un nuevo objeto que voy a utilizar
lista_de_calendarios = Archivo.new
#guardo el contenido del archivo que contiene la lista de los calendarios existentes
calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
#creo un nuevo objeto que voy a utilizar
calendario = Archivo.new
#defino nombre del campo id dentro del json que conforma cada evento
campo_id_en_json_evento = 'id'

#funcion para crear un calendario
post '/calendarios' do
  #paso json ingresado por usuario a variable
  params = JSON.parse(request.body.read)
  #devuelvo el status resultante del intento de creacion de calendario
  status calendario.crear_nuevo_calendario(params)
=begin
  #tomo de parametros ingresados el nombre del calendario a crear
  nombre_calendario_a_crear = params['nombre'].downcase unless params['nombre'].nil?
  #si existen los parametros pasados por usuario y si no existe ya el calendario en la lista
  if (!params.nil? && !calendario.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_crear))
    #agrego nuevo calendario dentro de la lista de calendarios
    lista_de_calendarios.escribir(nombre_archivo_lista_calendarios, nombre_calendario_a_crear)
    #creo el nuevo archivo con el nuevo nombre recibido por json
    calendario.crear_y_escribir(nombre_calendario_a_crear,'')
    #devuelvo status
    status 201
  else
    #devuelvo status
    status 400
  end
=end
end

#to-do sacar variable lista de calendarios y definirla solo 1 vez

#crear funcion en archivo para verificar si archivo esta vacio
#y que esa sea la primera verificacion cuando hay que listar cal o eventos

#funcion para listar todos los calendarios
get '/calendarios' do
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #creo un nuevo objeto archivo que voy a utilizar
    #lista_de_calendarios = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    #calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    body calendario.mostrar_todos_los_calendarios_existentes_como_json()
    #devuelvo status
    status 200
end

#funcion para borrar un calendario
delete '/calendarios/:nombre' do
  status calendario.eliminar_calendario(params)
=begin
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_calendario_a_eliminar = params[:nombre].downcase
  if (!nombre_calendario_a_eliminar.nil?)
    #creo un nuevo objeto archivo que voy a utilizar
    ##calendario = Archivo.new
    #borro el archivo del calendario indicado por el usuario
    calendario.borrar_archivo(nombre_calendario_a_eliminar)
    #creo un nuevo objeto archivo que voy a utilizar
    actualizar_lista_calendarios = Archivo.new
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #busco el calendario en la lista y lo elimino
    actualizar_lista_calendarios.busca_contenido_y_elimina(nombre_archivo_lista_calendarios, nombre_calendario_a_eliminar)
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
=end
end

#funcion para buscar si existe un calendario
get '/calendarios/:nombre' do
  body calendario.busco_calendario_por_su_nombre(params)
  status calendario.status_de_buscar_calendario_por_su_nombre(params)
=begin
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_calendario_a_mostrar = params[:nombre].downcase
  #nombre de archivo que tiene la lista de calendarios
  #nombre_archivo_lista_calendarios = 'lista_de_calendarios'
  #creo un nuevo objeto archivo que voy a utilizar
  ##calendario_a_buscar = Archivo.new
  if (!nombre_calendario_a_mostrar.nil? & calendario.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
    #preparo el json con el nombre del calendario, ya verificada su existencia
    json_a_devolver = {'nombre' => nombre_calendario_a_mostrar}
    #muestra el calendario como json
    body JSON[json_a_devolver]
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
=end  
end

#funcion para agregar un evento
post '/eventos' do
  #paso json ingresado por usuario a variable
  params = JSON.parse(request.body.read) unless request.body.nil?
  #guardo el nombre del calendario donde se quiere crear el evento
  nombre_calendario_a_modificar = params['calendario'].downcase unless params['calendario'].nil?
  #creo un nuevo objeto archivo que voy a utilizar  
  ##archivo = Archivo.new
  if (!params.nil? && !params['calendario'].nil? && !params['id'].nil?)
    #creo nuevo evento con los parametros de json
    nuevo_evento = Evento.new params['calendario'].downcase, params['id'], params['nombre'], params['inicio'], params['fin'], params['recurrencia']
    #abro el archivo calendario con el nombre recibido por json y guardo el evento
    calendario.escribir(nombre_calendario_a_modificar,nuevo_evento.mostrar_contenido())
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end

=begin
#funcion para mostrar todos los eventos
get '/eventos' do
  if (params[:calendario].nil?)
  #paso el id del evento ingresado por el usuario a variable
  #id_evento_a_eliminar = params[:id].downcase
  #if (!id_evento_a_eliminar.nil?)
    #nombre de archivo que tiene la lista de calendarios
    nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #creo un nuevo objeto archivo que voy a utilizar
    lista_de_calendarios = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #creo un nuevo objeto archivo que voy a utilizar
    calendario = Archivo.new
    #preparo la variable para que al menos exista contenido vacio para mostrar
    texto_a_mostrar = ''
    #recorro cada calendario de la lista de calendarios existentes
    #verifica que exista al menos un calendario para iterar
    if (calendarios_existentes.size > 1)
      calendarios_existentes.each_line { |line|
        #if (!line.nil?)
          un_calendario = line.chomp
          #guardo el contenido del archivo que guarda la lista de calendarios existentes
          lista_de_eventos = calendario.leer(un_calendario)
          if (!lista_de_eventos.nil? && lista_de_eventos.size > 1)
            #recorro cada evento de un calendario existente
            lista_de_eventos.each_line { |line|
              #evento_iterado = line.chomp
              if (!line.nil?)
                #guardo el contenido de cada evento
                texto_a_mostrar += line.chomp
              end
            }
          end
        #end  
      }
    end  
    #muestra lista de calendarios
    body texto_a_mostrar
    #body "test!!"
    #devuelvo status
    status 200
  end
end
=end

#funcion para mostrar los eventos, los de un calendario especifico o todos
get '/eventos' do
  #si se especifica un calendario se mostraran los eventos del mismo
  if (!params[:calendario].nil?)
    #paso nombre de calendario ingresado por el usuario a variable
    nombre_calendario_a_mostrar = params[:calendario].downcase
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios'
    #creo un nuevo objeto archivo que voy a utilizar
    ##calendario_a_buscar = Archivo.new
    if (!nombre_calendario_a_mostrar.nil? & calendario.verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
      #creo un nuevo objeto archivo que voy a utilizar
      lista_de_eventos = Archivo.new
      #guardo el contenido del archivo que guarda la lista de calendarios existentes
      texto_a_mostrar = lista_de_eventos.leer(nombre_calendario_a_mostrar)
      #muestra lista de calendarios
      body texto_a_mostrar
      #devuelvo status
      status 200
    else
      #devuelvo status
      status 400
    end
  #si no se especifica ningun calendario se mostraran todos los eventos de todos los calendarios
  elsif (params[:calendario].nil?)
  #elsif (params[:calendario].nil? && params[:id].nil?)
  #elsif (params.nil?)
  #paso el id del evento ingresado por el usuario a variable
  #id_evento_a_eliminar = params[:id].downcase
  #if (!id_evento_a_eliminar.nil?)
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #creo un nuevo objeto archivo que voy a utilizar
    ##lista_de_calendarios = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    ##calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #creo un nuevo objeto archivo que voy a utilizar
    ##calendario = Archivo.new
    #preparo la variable para que al menos exista contenido vacio para mostrar
    texto_a_mostrar = ''
    #recorro cada calendario de la lista de calendarios existentes
    #verifica que exista al menos un calendario para iterar
    if (calendarios_existentes.size > 1)
      calendarios_existentes.each_line { |line|
        #if (!line.nil?)
          un_calendario = line.chomp
          #guardo el contenido del archivo que guarda la lista de calendarios existentes
          lista_de_eventos = calendario.leer(un_calendario)
          if (!lista_de_eventos.nil? && lista_de_eventos.size > 1)
            #recorro cada evento de un calendario existente
            lista_de_eventos.each_line { |line2|
              #evento_iterado = line.chomp
              if (!line2.nil?)
                #guardo el contenido de cada evento
                texto_a_mostrar += line2.chomp
              end
            }
          end
        #end  
      }
    end
    #muestra lista de eventos del calendario solicitado
    body texto_a_mostrar
    #devuelvo status
    status 200
  end
end


#funcion para mostrar un evento segun el id solicitado
get '/eventos/:id' do
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_evento_a_mostrar = params[:id].downcase
  if (!nombre_evento_a_mostrar.nil?)
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #nombre del campo identificador a buscar dentro de json de eventos a borrar
    ##campo_id_en_json_evento = 'id'
    #creo un nuevo objeto archivo que voy a utilizar
    ##lista_de_calendarios = Archivo.new
    #preparo la variable para que al menos exista contenido vacio para mostrar
    texto_a_mostrar = ''
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    ##calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #creo un nuevo objeto archivo que voy a utilizar
    ##calendario = Archivo.new
    #recorro cada calendario de la lista de calendarios existentes
    calendarios_existentes.each_line { |line|
      if (!line.nil?)
        un_calendario = line.chomp
        #busco el evento en la lista y lo elimino
        texto_a_mostrar += calendario.busca_contenido_por_id_y_lo_muestra(un_calendario, campo_id_en_json_evento, nombre_evento_a_mostrar)
      end
    }
    #muestro los eventos encontrados con el identificador solicitado
    body texto_a_mostrar
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end

#funcion para borrar un evento
delete '/eventos/:id' do
  #paso nombre de calendario ingresado por el usuario a variable
  nombre_evento_a_eliminar = params[:id].downcase
  if (!nombre_evento_a_eliminar.nil?)
    #nombre de archivo que tiene la lista de calendarios
    #nombre_archivo_lista_calendarios = 'lista_de_calendarios' 
    #nombre del campo identificador a buscar dentro de json de eventos a borrar
    ##campo_id_en_json_evento = 'id'
    #creo un nuevo objeto archivo que voy a utilizar
    ##lista_de_calendarios = Archivo.new
    #guardo el contenido del archivo que guarda la lista de calendarios existentes
    ##calendarios_existentes = lista_de_calendarios.leer(nombre_archivo_lista_calendarios)
    #creo un nuevo objeto archivo que voy a utilizar
    ##calendario = Archivo.new
    #recorro cada calendario de la lista de calendarios existentes
    calendarios_existentes.each_line { |line|
      if (!line.nil?)
        un_calendario = line.chomp
        #busco el evento en la lista y lo elimino
        calendario.busca_contenido_por_id_y_elimina(un_calendario, campo_id_en_json_evento, nombre_evento_a_eliminar)
      end
    }
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end

#funcion para modificar un evento segun el id solicitado
put '/eventos' do
  #paso json ingresado por usuario a variable
  params = JSON.parse(request.body.read) unless request.body.nil?
  #inicializo variable por si no se pasa el calendario, para modificar evento en todos los calendarios
  nombre_calendario_a_modificar = ''
  #tomo de parametros ingresados el nombre del calendario a modificar
  nombre_calendario_a_modificar = params['calendario'].downcase unless params['calendario'].nil?
  #tomo de parametros ingresados el nombre del calendario a modificar
  id_evento_a_modificar = params['id'].downcase unless params['id'].nil?
  #es obligatorio ingresar el id del evento
  if (!id_evento_a_modificar.nil?)
    calendario.busca_contenido_por_id_y_modifica(nombre_calendario_a_modificar, campo_id_en_json_evento, id_evento_a_modificar, params)
    #devuelvo status
    status 200
  else
    #devuelvo status
    status 400
  end
end
