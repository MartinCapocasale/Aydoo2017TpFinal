class Calendario

	attr_accessor :evento
	attr_accessor :nombre

	def initialize(nombre)
		self.nombre = nombre
		evento = Array.new
	end

	def agregarEventoAlCalendario(unEvento)
		self.evento.push unEvento
	end

=begin
	def getEventos(iD)
		return 

	end	
=end
end