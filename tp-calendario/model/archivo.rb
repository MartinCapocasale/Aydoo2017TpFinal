class Archivo

	def escribir(nombre_de_archivo, texto_a_escribir)
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "a") { |f|
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
	  if File.file?(nombre_de_archivo)
	    f = File.open(nombre_de_archivo, "w") { |f|
	  	  f.puts(contenido)
	  	}
	  end
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
	  if File.file?(nombre_de_archivo)
	    f = File.open(nombre_de_archivo, "w") { |f|
	  	  f.puts(contenido)
	  	}
	  end
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
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "r")
		f.each_line { |line|
		  linea_sin_new_line = line.chomp
		  if (linea_sin_new_line != '')
			json_de_evento = JSON.parse(linea_sin_new_line)
			if (json_de_evento[identificador_a_buscar] = contenido_del_identificador)
			  #contenido += line
			  contenido = "EVENTO ENCONTRADO"
			end
		  end  
		}
		f.close
	  end
	  return contenido
	end

end
