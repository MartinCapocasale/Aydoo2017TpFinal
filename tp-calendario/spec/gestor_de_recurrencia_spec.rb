require 'rspec'
require_relative '../model/gestor_de_recurrencia'


describe 'Gestor De Recurrencia' do

  it 'Se prueba crear un evento recurrente con frecuencia y fin frecuencia' do
    nombre_calendario = 'MiCalendario'
    id = '1'
    nombre = 'Evento'
    inicio = DateTime.now
    fin = inicio
    recurrencia = 'mensual'
    frecuencia = double('Frecuencia')
    allow(frecuencia).to receive(:frecuencia).and_return(1)
    fin_recurrencia = DateTime.now + 30
    GestorDeRecurrencia.new(nombre_calendario, id, nombre, inicio, fin, recurrencia, frecuencia, fin_recurrencia)
  end

    
  it 'Se prueba obtener la frecuencia con la que se creo el evento' do
    nombre_calendario = 'MiCalendario'
    id = '1'
    nombre = 'Evento'
    inicio = DateTime.now
    fin = inicio
    recurrencia = 'mensual'
    frecuencia = double('Frecuencia')
    allow(frecuencia).to receive(:frecuencia).and_return(1)
    fin_recurrencia = DateTime.now + 30
    gestor_de_recurrencia = GestorDeRecurrencia.new(nombre_calendario, id, nombre, inicio, fin, recurrencia, frecuencia, fin_recurrencia)
    expect(gestor_de_recurrencia.frecuencia).to eq frecuencia
  end


  it 'Se prueba obtener el fin de recurrencia con la que se creo el evento' do
    nombre_calendario = 'MiCalendario'
    id = '1'
    nombre = 'Evento'
    inicio = DateTime.now
    fin = inicio
    recurrencia = 'mensual'
    frecuencia = double('Frecuencia')
    allow(frecuencia).to receive(:frecuencia).and_return(1)
    fin_recurrencia = DateTime.now + 30
    gestor_de_recurrencia = GestorDeRecurrencia.new(nombre_calendario, id, nombre, inicio, fin, recurrencia, frecuencia, fin_recurrencia)
    expect(gestor_de_recurrencia.obtener_fecha_fin).to eq fin_recurrencia
  end

end