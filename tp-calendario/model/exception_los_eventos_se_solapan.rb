class ExceptionLosEventosSeSolapan < ArgumentError

  def initialize(msg = 'No puede haber dos eventos en la misma franja horaria')
    super
  end
end
