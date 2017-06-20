require_relative './calendario.rb'

class Gestor_De_Recurrencia

    def generar_recurrencia(nombre_calendario, id, nombre, inicio, fin, frecuencia, fin_recurrencia)
	  #creo un nuevo objeto que voy a utilizar
	  calendario = Calendario.new

      #si la frecuencia es diaria
      if (frecuencia == 'diaria')
		#comenzar un ciclo para sumar 1 a los dias hasta llegar al fin
      	#inicio = inicio +1
      	#fin = fin + 1	    
	    #armo el nuevo json a repetir
	    #json = {"calendario" => 'calendario1', "id" => 'id_pepito', "nombre" => 'evento uno', "inicio" => '2017-07-30T18:00:00-03:00', "fin" => '2017-07-30T19:00:00-03:00'}
      	#calendario.agregar_un_evento(json)
      end

      #si la frecuencia es semanal
      if (frecuencia == 'semanal')
		#comenzar un ciclo para sumar 1 semana a los dias hasta llegar al fin
      	#inicio = inicio +1 semana
      	#fin = fin + 1 semana
	    #armo el nuevo json a repetir
	    #json = {"calendario" => 'calendario1', "id" => 'id_pepito', "nombre" => 'evento uno', "inicio" => '2017-07-30T18:00:00-03:00', "fin" => '2017-07-30T19:00:00-03:00'}
      	#calendario.agregar_un_evento(json)
      end

      #si la frecuencia es mensual
      if (frecuencia == 'mensual')
		#comenzar un ciclo para sumar 1 mes a los dias hasta llegar al fin
      	#inicio = inicio +1 mes
      	#fin = fin + 1 mes
	    #armo el nuevo json a repetir
	    #json = {"calendario" => 'calendario1', "id" => 'id_pepito', "nombre" => 'evento uno', "inicio" => '2017-07-30T18:00:00-03:00', "fin" => '2017-07-30T19:00:00-03:00'}
      	#calendario.agregar_un_evento(json)
      end
      
    end

end