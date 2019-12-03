class Visita
  @@id_static = 0
  attr_accessor :id, :arregloVisitantes, :fecha, :habitacion
  def initialize(fecha, habitacion)
    @@id_static += 1
    @id = @@id_static
    @fecha, @habitacion = fecha, habitacion
    @arregloVisitantes = []
  end

  def registrarVisitante(visitante)
    arregloVisitantes<<visitante
  end
end