class Evento

	attr_accessor :iD
	attr_accessor :nombre
	attr_accessor :anio
	attr_accessor :mes
	attr_accessor :dia
	attr_accessor :horaInicio
	attr_accessor :HoraFin

	def initialize(iD,nombre,anio,mes,dia,horaInicio,HoraFin)
       self.iD = iD
       self.nombre = nombre
       self.anio = anio
       self.mes = mes
       self.dia = dia
       self.horaInicio = horaInicio
       self.HoraFin = HoraFin

    end
       

end