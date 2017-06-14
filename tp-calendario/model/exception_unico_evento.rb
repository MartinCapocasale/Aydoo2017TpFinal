class ExceptionUnicoEvento < ArgumentError

  def initialize(msg = 'No puede haber dos eventos repetidos')
    super
  end
end
