class Archivo

	#defino variable que contendra el nombre de archivo con lista de calendarios
	attr_reader :nombre_archivo_lista_calendarios
	attr_accessor :calendarios_existentes

	def initialize
	  #defino el nombre de archivo que tiene la lista de calendarios
	  #este archivo ya debe existir para poder guardar los calendarios que se generen
	  @nombre_archivo_lista_calendarios = "lista_de_calendarios"
	  #guardo el contenido del archivo que contiene la lista de los calendarios existentes
	  @calendarios_existentes = leer(@nombre_archivo_lista_calendarios)
	end  

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
	  contenido = ''
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "r")
		f.each_line { |line|
		  linea_sin_new_line = line.chomp
		  if (linea_sin_new_line != '')
			json_de_evento = JSON.parse(linea_sin_new_line)
			if (json_de_evento[identificador_a_buscar] != contenido_del_identificador)
			  contenido += line
			end
		  end  
		}
		f.close
	  end
	  borrar_contenido_anterior_y_escribir(nombre_de_archivo, contenido)
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

	  #return contenido
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
	  #return contenido
	end

end
