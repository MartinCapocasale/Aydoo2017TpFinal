require 'rspec' 
require_relative '../model/frecuencia'

describe 'Frecuencia' do

  before do
    @frecuencias = Frecuencia.new 
  end

  it 'se prueba FrecuenciaDiaria cuando se indica el tipo de frecuencia diaria' do
  	frecuencia = "diaria"
  	valor_obtenido = @frecuencias.set_Frecuencia(frecuencia)
  	valor_esperado = FrecuenciaDiaria
  	expect(valor_obtenido).to be_is_a(valor_esperado)
  end

  it 'se prueba FrecuenciaSemanal cuando se indica el tipo de frecuencia semanal' do
  	frecuencia = "semanal"
    valor_obtenido = @frecuencias.set_Frecuencia(frecuencia)
    valor_esperado = FrecuenciaSemanal
    expect(valor_obtenido).to be_is_a(valor_esperado)	
  end

  it 'se prueba FrecuenciaDiaria cuando se indica el tipo de frecuencia mensual' do
  	frecuencia = "mensual"
  	valor_obtenido = @frecuencias.set_Frecuencia(frecuencia)
    valor_esperado = FrecuenciaMensual
    expect(valor_obtenido).to be_is_a(valor_esperado)	
  end

  it 'se prueba FrecuenciaDiaria cuando se indica el tipo de frecuencia anual' do
  	frecuencia = "anual"
  	valor_obtenido = @frecuencias.set_Frecuencia(frecuencia)
    valor_esperado = FrecuenciaAnual
    expect(valor_obtenido).to be_is_a(valor_esperado)	
  end
end