class Habitacion
  @@id_static = 0
  attr_accessor :id, :numeroHabitacion, :propietario, :fecha, :arregloFamiliares, :arregloEstadoCuenta, :isDisponible

  def initialize(numeroHabitacion, propietario, fecha)
    @@id_static += 1
    @id = @@id_static
    @numeroHabitacion, @propietario, @fecha = numeroHabitacion, propietario, fecha
    @arregloFamiliares = []
    @arregloEstadoCuenta = []
    @isDisponible = true
  end

  def registrarEstadoCuentaServicio(estadoCuentaServicio)
    arregloEstadoCuenta << estadoCuentaServicio
  end

  def registrarFamiliar(familiar)
    arregloFamiliares << familiar
  end

  def registrarPropietario(persona)
    self.isDisponible = false
    self.propietario = persona
  end

  def pagarEstadoCuenta(estadoCuenta)
    estadoCuenta.pagarCuenta
  end

end