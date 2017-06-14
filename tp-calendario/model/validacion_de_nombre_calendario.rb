require_relative './exception_validacion_de_duracion'


class ValidacionDeNombreCalendario

	attr_accessor :nombre

	def initialize(un_nombre)
		if(nombre == '')
			raise ExceptionValidacionDeNombreCalendario
		end	
		@nombre = un_nombre

	end
end		