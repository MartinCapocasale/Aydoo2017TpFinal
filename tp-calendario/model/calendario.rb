require_relative './evento.rb'

class Calendario

	#defino variable que contendra el nombre de archivo con lista de calendarios
	attr_reader :nombre_archivo_lista_calendarios
	attr_accessor :calendarios_existentes
	attr_reader :campo_id_en_json_evento

	def initialize
	  #defino el nombre de archivo que tiene la lista de calendarios
	  #este archivo ya debe existir para poder guardar los calendarios que se generen
	  @nombre_archivo_lista_calendarios = "lista_de_calendarios"
	  #guardo el contenido del archivo que contiene la lista de los calendarios existentes
	  @calendarios_existentes = leer(@nombre_archivo_lista_calendarios)
	  #defino nombre del campo id dentro del json que conforma cada evento
		@campo_id_en_json_evento = 'id'
	end  

#Comienzan las funciones especificas de Archivos

	def escribir(nombre_de_archivo, texto_a_escribir)
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "a") { |f|
		  f.puts(texto_a_escribir)
		}
	  end
	end

	def borrar_contenido_anterior_y_escribir(nombre_de_archivo, texto_a_escribir)
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "w") { |f|
		  f.puts(texto_a_escribir)
		}
	  end
	end

	def borrar_archivo(nombre_de_archivo)
	  if File.file?(nombre_de_archivo)
	    File.delete(nombre_de_archivo)
	  end
	end

	def crear_y_escribir(nombre_de_archivo, texto_a_escribir)
	  if !File.exists?(nombre_de_archivo)
	    f = File.open(nombre_de_archivo, "w") { |f|
	  	  f.puts(texto_a_escribir)
	    }
	  end    
	end

	def leer(nombre_de_archivo)
	  contenido = ''
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "r")
		f.each_line { |line|
		  contenido += line
		}
		f.close
		return contenido
	  end
	end

	def verificar_si_existe(nombre_de_archivo, contenido_a_verificar)
	  existe_en_archivo = false
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "r")
		f.each_line { |line|
		  linea_sin_new_line = line.chomp
		  if (linea_sin_new_line == contenido_a_verificar)
		  	existe_en_archivo = true
		  end
		}
		f.close
	  end
	  return existe_en_archivo
	end

#Comienzan las funciones especificas de los calendarios

	def crear_nuevo_calendario(json)
	  #tomo de parametros ingresados el nombre del calendario a crear
	  nombre_calendario_a_crear = json['nombre'].downcase unless json['nombre'].nil?
	  #si existen los parametros pasados por usuario y si no existe ya el calendario en la lista
	  if (!json.nil? && !verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_crear))
	    #agrego nuevo calendario dentro de la lista de calendarios
	    escribir(nombre_archivo_lista_calendarios, nombre_calendario_a_crear)
	    #creo el nuevo archivo con el nuevo nombre recibido por json
	    crear_y_escribir(nombre_calendario_a_crear,'')
	    #devuelvo valor para status
	    return 201
	  else
	    #devuelvo valor para status
	    return 400
	  end 
	end

	def mostrar_todos_los_calendarios_existentes_como_json()
	  #inicializo variable para mostrar al menos contenido vacio si no hay calendarios
      json_a_mostrar = ''
      if (calendarios_existentes.size > 1)
        calendarios_existentes.each_line { |line|
          if (!line.chomp.nil? && line.chomp != '')
            nombre_calendario_a_json = {'nombre' => line.chomp}
            json_a_mostrar += JSON[nombre_calendario_a_json]
          end
        }
      end
      #devuelvo json de calendarios
      return json_a_mostrar
	end

	def eliminar_calendario(params)
	  #paso nombre de calendario ingresado por el usuario a variable
	  nombre_calendario_a_eliminar = params[:nombre].downcase unless params.nil?
	  if (!nombre_calendario_a_eliminar.nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_eliminar))
	    #borro el archivo del calendario indicado por el usuario
	    borrar_archivo(nombre_calendario_a_eliminar)
	    #busco el calendario en la lista y lo elimino
	    busca_contenido_y_elimina(nombre_archivo_lista_calendarios, nombre_calendario_a_eliminar)
	    #devuelvo valor para status
	    return 200
	  else
	    #devuelvo valor para status
	    return 400
	  end		
	end

	def buscar_calendario_por_su_nombre(params)
	  #inicializo la variable para mostrar contenido vacio si no existe calendario
	  json_a_mostrar = ''
	  #paso nombre de calendario ingresado por el usuario a variable
	  nombre_calendario_a_mostrar = params[:nombre].downcase unless params.nil?
	  #si existe el calendario
	  if (!nombre_calendario_a_mostrar.nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
	    #preparo el json con el nombre del calendario, ya verificada su existencia
	    json_a_devolver = {'nombre' => nombre_calendario_a_mostrar}
	    #convierte el string a json
	    json_a_mostrar = JSON[json_a_devolver]
	  end
	  #devuelve el contenido a mostrar
	  return json_a_mostrar
	end	

	def status_de_buscar_calendario_por_su_nombre(params)
	  #paso nombre de calendario ingresado por el usuario a variable
	  nombre_calendario_a_mostrar = params[:nombre].downcase unless params.nil?
	  #si existe el calendario
	  if (!nombre_calendario_a_mostrar.nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
	    #devuelvo valor para status
	    return 200
	  else
	    #devuelvo valor para status
	    return 400
	  end
	end	

	def agregar_un_evento(params)
	  #guardo el nombre del calendario donde se quiere crear el evento
	  nombre_calendario_a_modificar = params['calendario'].downcase unless params['calendario'].nil?
	  #si usuario envio calendario y existe
	  if (!params.nil? && !params['calendario'].nil? && !params['id'].nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_modificar))
	    #verifico que no exista id dentro del calendario
	    if (busca_contenido_por_id_y_lo_muestra(nombre_calendario_a_modificar, @campo_id_en_json_evento, params['id']) == '')
		    #creo nuevo evento con los parametros de json
		    nuevo_evento = Evento.new params['calendario'].downcase, params['id'], params['nombre'], params['inicio'], params['fin'], params['recurrencia']
		    #abro el archivo calendario con el nombre recibido por json y guardo el evento
		    escribir(nombre_calendario_a_modificar,nuevo_evento.mostrar_contenido())
		    #devuelvo valor para status
		    return 200
	  	#end
		  else
		    #devuelvo valor para status
		    return 400
		  end
		end  
	end

	def mostrar_eventos_de_un_calendario(params)
    #inicializo variable para mostrar contenido vacio en caso de que no exista calendario
    texto_a_mostrar = ''
    #paso nombre de calendario ingresado por el usuario a variable
    nombre_calendario_a_mostrar = params[:calendario].downcase unless params.nil?
    #si el calendario indicado existe
    if (!nombre_calendario_a_mostrar.nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
      #guardo el contenido del archivo que guarda la lista de calendarios existentes
      texto_a_mostrar = leer(nombre_calendario_a_mostrar)
    end
    #devuelvo lista de eventos
    return texto_a_mostrar
	end

	def status_de_mostrar_eventos_de_un_calendario(params)
    #paso nombre de calendario ingresado por el usuario a variable
    nombre_calendario_a_mostrar = params[:calendario].downcase unless params.nil?
    #si el calendario indicado existe
    if (!nombre_calendario_a_mostrar.nil? && verificar_si_existe(nombre_archivo_lista_calendarios, nombre_calendario_a_mostrar)) 
      #devuelvo valor para status
      return 200
    else
      #devuelvo valor para status
      return 400
    end
	end

	def mostrar_eventos_de_todos_los_calendarios(params)
	  #preparo la variable para que al menos exista contenido vacio para mostrar
    texto_a_mostrar = ''
    #recorro cada calendario de la lista de calendarios existentes
    #verifica que exista al menos un calendario para iterar
    if (calendarios_existentes.size > 1)
      calendarios_existentes.each_line { |line|
        un_calendario = line.chomp
        #guardo el contenido del archivo que guarda la lista de calendarios existentes
        lista_de_eventos = leer(un_calendario)
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
      }
    end
    #devuelve lista de eventos de todos los calendarios
    return texto_a_mostrar
	end

	def mostrar_evento_segun_id(params)
		#inicializo variable para mostrar vacio si evento no existe
		texto_a_mostrar = ''
		#paso nombre de calendario ingresado por el usuario a variable
	  nombre_evento_a_mostrar = params[:id].downcase unless params.nil?
	  if (!nombre_evento_a_mostrar.nil?)
	    #recorro cada calendario de la lista de calendarios existentes
	    calendarios_existentes.each_line { |line|
	      if (!line.nil?)
	        un_calendario = line.chomp
	        #busco el evento en la lista y lo elimino
	        texto_a_mostrar += busca_contenido_por_id_y_lo_muestra(un_calendario, @campo_id_en_json_evento, nombre_evento_a_mostrar)
	      end
	    }
	  end
	  #devuelvo los eventos encontrados con el identificador solicitado
	  return texto_a_mostrar
	end

	def status_de_mostrar_evento_segun_id(params)
		#paso nombre de calendario ingresado por el usuario a variable
	  nombre_evento_a_mostrar = params[:id].downcase unless params.nil?
	  if (!nombre_evento_a_mostrar.nil? && mostrar_evento_segun_id(params) != '')
	    #devuelvo valor para status
	    return 200
	  else
	    #devuelvo valor para status
	    return 400
	  end
	end

	def eliminar_evento_por_id(params)
		#inicializo variable para verificar si hubo eliminacion
		eliminado = ''
		#paso nombre de calendario ingresado por el usuario a variable
	  nombre_evento_a_eliminar = params[:id].downcase unless params.nil?
	  if (!nombre_evento_a_eliminar.nil?)
	    #recorro cada calendario de la lista de calendarios existentes
	    calendarios_existentes.each_line { |line|
	      if (!line.nil?)
	        un_calendario = line.chomp
	        #busco el evento en la lista y lo elimino
	        eliminado = busca_contenido_por_id_y_elimina(un_calendario, @campo_id_en_json_evento, nombre_evento_a_eliminar)
	      end
	    }
	  end
	  if (eliminado != '')
	  	#devuelvo valor para status
	    return 200
	  else
	    #devuelvo valor para status
	    return 400
	  end
	end

	def modificar_un_evento_por_id(params)
		#inicializo variable por si no se pasa el calendario, para modificar evento en todos los calendarios
	  nombre_calendario_a_modificar = ''
	  #tomo de parametros ingresados el nombre del calendario a modificar
	  nombre_calendario_a_modificar = params['calendario'].downcase unless params['calendario'].nil?
	  #tomo de parametros ingresados el nombre del calendario a modificar
	  id_evento_a_modificar = params['id'].downcase unless params['id'].nil?
	  #es obligatorio ingresar el id del evento
	  if (!id_evento_a_modificar.nil?)
	    busca_contenido_por_id_y_modifica(nombre_calendario_a_modificar, @campo_id_en_json_evento, id_evento_a_modificar, params)
	    #devuelvo valor para status
	    return 200
	  else
	    #devuelvo valor para status
	    return 400
	  end
	end

	def busca_contenido_y_elimina(nombre_de_archivo, contenido_a_eliminar)
	  contenido = ''
	  if File.file?(nombre_de_archivo)
			f = File.open(nombre_de_archivo, "r")
			f.each_line { |line|
			  linea_sin_new_line = line.chomp
			  if (linea_sin_new_line != contenido_a_eliminar)
			  	contenido += line
			  end
			}
			f.close
	  end
	  borrar_contenido_anterior_y_escribir(nombre_de_archivo, contenido)
	end

	def busca_contenido_por_id_y_elimina(nombre_de_archivo, identificador_a_buscar, contenido_del_identificador)
	  verificacion_de_eliminado = ''
	  contenido = ''
	  if File.file?(nombre_de_archivo)
			f = File.open(nombre_de_archivo, "r")
			f.each_line { |line|
			  linea_sin_new_line = line.chomp
			  if (linea_sin_new_line != '')
					json_de_evento = JSON.parse(linea_sin_new_line)
					if (json_de_evento[identificador_a_buscar] != contenido_del_identificador)
					  contenido += line
					else
				  	verificacion_de_eliminado = "ok"
				  end
			  end  
			}
			f.close
	  end
	  borrar_contenido_anterior_y_escribir(nombre_de_archivo, contenido)
	  return verificacion_de_eliminado
	end

	def busca_contenido_por_id_y_lo_muestra(nombre_de_archivo, identificador_a_buscar, contenido_del_identificador)
	  contenido = ''
	  if File.file?(nombre_de_archivo)
			f = File.open(nombre_de_archivo, "r")
			f.each_line { |line|
			  linea_sin_new_line = line.chomp
			  if (linea_sin_new_line != '')
					json_de_evento = JSON.parse(linea_sin_new_line)
					if (json_de_evento[identificador_a_buscar] == contenido_del_identificador)
					  contenido += linea_sin_new_line
					end
			  end  
			}
			f.close
	  end
	  return contenido
	end

	def busca_contenido_por_id_y_modifica(nombre_de_archivo, identificador_a_buscar, contenido_del_identificador, json_con_nuevos_datos)
	  contenido = ''
	  #si nombre_de_archivo tiene contenido se busca el calendario indicado por el usuario
	  if (nombre_de_archivo != '')
	    if File.file?(nombre_de_archivo)
			  f = File.open(nombre_de_archivo, "r")
			  f.each_line { |line|
			    linea_sin_new_line = line.chomp
			    if (linea_sin_new_line != '')
					  json_de_evento = JSON.parse(linea_sin_new_line)
					  #pregunto a cada evento si es el buscado
					  if (json_de_evento[identificador_a_buscar] = contenido_del_identificador)
					    #creo nuevo evento con los parametros de json del evento encontrado
					    evento_encontrado = Evento.new json_de_evento['calendario'].downcase, json_de_evento['id'].downcase, json_de_evento['nombre'].downcase, json_de_evento['inicio'], json_de_evento['fin'], json_de_evento['recurrencia']
					    #creo nuevo evento con los parametros de json del evento modificado enviado por usuario
					    nuevo_evento = Evento.new json_con_nuevos_datos['calendario'].downcase, json_con_nuevos_datos['id'].downcase, json_con_nuevos_datos['nombre'], json_con_nuevos_datos['inicio'], json_con_nuevos_datos['fin'], json_con_nuevos_datos['recurrencia']
					    #abro el archivo calendario con el nombre recibido por json y guardo el evento
					    contenido += evento_encontrado.actualizar_evento(nuevo_evento)
					  else
					  	contenido += line
					  end
			    end  
			  }
			  f.close
	    end
		borrar_contenido_anterior_y_escribir(nombre_de_archivo, contenido)
	  #si nombre_de_archivo llega vacio es porque el evento se debe modificar en todos los calendarios
	  elsif (nombre_de_archivo == '')
	  	#recorro todos los calendarios buscando el evento
	  	recorro_todos_los_calendarios_y_busco_evento_por_id(identificador_a_buscar, contenido_del_identificador, json_con_nuevos_datos)
	  end
	end

	def recorro_todos_los_calendarios_y_busco_evento_por_id(identificador_a_buscar, contenido_del_identificador, json_con_nuevos_datos)
	  #recorro cada calendario de la lista de calendarios existentes
	  #verifica que exista al menos un calendario para iterar
	  if (@calendarios_existentes.size > 1)
	    @calendarios_existentes.each_line { |line|
	      un_calendario = line.chomp
	      #guardo el contenido del archivo que guarda la lista de calendarios existentes
	      lista_de_eventos = leer(un_calendario)
	      if (!lista_de_eventos.nil? && lista_de_eventos.size > 1)
	        #preparo la variable que guardara los eventos del calendario iterado
	  		contenido = ''
	        #recorro cada evento de un calendario existente
	        lista_de_eventos.each_line { |line2|
			      linea_sin_new_line = line2.chomp
			      if (linea_sin_new_line != '')
					    json_de_evento = JSON.parse(linea_sin_new_line)
					    #pregunto a cada evento si es el buscado
					    if (json_de_evento[identificador_a_buscar] = contenido_del_identificador)
					      #creo nuevo evento con los parametros de json del evento encontrado
					      evento_encontrado = Evento.new json_de_evento['calendario'].downcase, json_de_evento['id'].downcase, json_de_evento['nombre'].downcase, json_de_evento['inicio'], json_de_evento['fin'], json_de_evento['recurrencia']
					      #creo nuevo evento con los parametros de json del evento modificado enviado por usuario
					      nuevo_evento = Evento.new json_con_nuevos_datos['calendario'], json_con_nuevos_datos['id'].downcase, json_con_nuevos_datos['nombre'], json_con_nuevos_datos['inicio'], json_con_nuevos_datos['fin'], json_con_nuevos_datos['recurrencia']
					      #abro el archivo calendario con el nombre recibido por json y guardo el evento
					      contenido += evento_encontrado.actualizar_evento(nuevo_evento)
					    else
					      contenido += line2
					    end
					  end
					}
	  		end
	  		borrar_contenido_anterior_y_escribir(un_calendario, contenido)
	    }
	  end
	end

end
