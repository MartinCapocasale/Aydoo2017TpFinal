require 'sinatra'
require 'json'
require_relative './model/calendario.rb'

#creo un nuevo objeto que voy a utilizar
calendario = Calendario.new

#funcion para crear un calendario
post '/calendarios' do
  params = JSON.parse(request.body.read) unless request.body.nil?
  status calendario.crear_nuevo_calendario(params)
end

#funcion para listar todos los calendarios
get '/calendarios' do
    body calendario.mostrar_todos_los_calendarios_existentes_como_json()
    status 200
end

#funcion para borrar un calendario
delete '/calendarios/:nombre' do
  status calendario.eliminar_calendario(params)
end

#funcion para buscar si existe un calendario
get '/calendarios/:nombre' do
  body calendario.buscar_calendario_por_su_nombre(params)
  status calendario.status_de_buscar_calendario_por_su_nombre(params)
end

#funcion para agregar un evento
post '/eventos' do
  params = JSON.parse(request.body.read) unless request.body.nil?
  status calendario.agregar_un_evento(params)
end

#funcion para mostrar los eventos, los de un calendario especifico o todos
get '/eventos' do
  #si se especifica un calendario se mostraran los eventos del mismo
  if (!params[:calendario].nil?)
    body calendario.mostrar_eventos_de_un_calendario(params)
    status calendario.status_de_mostrar_eventos_de_un_calendario(params)
  #si no se especifica ningun calendario se mostraran todos los eventos de todos los calendarios
  elsif (params[:calendario].nil?)
    body calendario.mostrar_eventos_de_todos_los_calendarios(params)
    status 200
  end
end

#funcion para mostrar un evento segun el id solicitado
get '/eventos/:id' do
  body calendario.mostrar_evento_segun_id(params)
  status calendario.status_de_mostrar_evento_segun_id(params)
end

#funcion para borrar un evento
delete '/eventos/:id' do
  status calendario.eliminar_evento_por_id(params)
end

#funcion para modificar un evento segun el id solicitado
put '/eventos' do
  params = JSON.parse(request.body.read) unless request.body.nil?
  status calendario.modificar_un_evento_por_id(params)
end
