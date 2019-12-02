class Habitacion
  @@id_static
  attr_accessor :id, :numeroHabitacion, :propietario, :fecha, :arregloFamiliares, :arregloEstadoCuenta

  def initialize(numeroHabitacion, propietario, fecha)
    @@id_static += 1
    @id = @@id_static
    @numeroHabitacion, @propietario, @fecha = id, numeroHabitacion, propietario, fecha
    @arregloFamiliares = []
    @arregloEstadoCuenta = []
  end

  def registrarEstadoCuentaServicio(estadoCuentaServicio)
    arregloEstadoCuenta << estadoCuentaServicio
  end

  def registrarFamiliar(familiar)
    arregloFamiliares << familiar
  end
end