require 'sinatra'
require_relative './model/calendario'
require_relative './model/evento'


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

end