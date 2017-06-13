class ExceptionValidacionDeDuracion < ArgumentError

  def initialize(msg = 'Fin no puede ser menor a inicio y el evento no puede ser mayor a 72hs')
    super
  end
end