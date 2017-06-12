class ExceptionValidacionDeDuracion < StandardError

  def initialize(msg = 'Fin no puede ser menor a inicio')
    super
  end
end