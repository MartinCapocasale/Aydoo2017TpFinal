require_relative './exception_validacion_de_nombre_calendario'


class ValidacionDeNombreCalendario

	@nombre = ''

	def initialize(un_nombre)
		if(un_nombre == @nombre)
			raise ExceptionValidacionDeNombreCalendario
		end	
		@nombre = un_nombre

	end
end		