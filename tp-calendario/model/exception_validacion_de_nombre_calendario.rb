class ExceptionValidacionDeNombreCalendario < ArgumentError

  def initialize(msg = 'Un calendario debe tener un nombre')
    super
  end
end