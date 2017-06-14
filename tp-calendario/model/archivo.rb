class Archivo

	def escribir(nombre_de_archivo, texto_a_escribir)
	  if File.file?(nombre_de_archivo)
		f = File.open(nombre_de_archivo, "a") { |f|
		  f.puts(texto_a_escribir)
		}
		#f.close
	  end
	end

	def crear_y_escribir(nombre_de_archivo, texto_a_escribir)
	  if !File.exists?(nombre_de_archivo)
	    f = File.open(nombre_de_archivo, "w") { |f|
	  	  f.puts(texto_a_escribir)
	    }
	    #f.close
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

end