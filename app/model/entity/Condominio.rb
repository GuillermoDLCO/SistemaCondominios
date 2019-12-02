class Condominio
  @@id_static = 0

  attr_accessor :id, :nombre, :arregloHabitaciones, :arregloServicios, :arregloVisitas

  def initialize(nombre)
    @@id_static += 1
    @id = @@id_static
    @nombre = nombre
    @arregloHabitaciones = []
    @arregloServicios = []
    @arregloVisitas = []

  end

  def registrarHabitacion(habitacion)
    arregloHabitaciones<<habitacion
  end

  def registrarServicio(servicio)
    arregloServicios<<servicio
  end

  def registrarVisita(visita)
    arregloVisitas<<visita
  end

  def calcularPagoServicioPorHabitacion
    totalServicio = 0
    for s in arregloServicios
      totalServicio += s.costo
    end

    pagoPorHabitacion = (totalServicio * 1.0 / arregloHabitaciones.length).round(2)

    return pagoPorHabitacion
  end

  def generarCuentasServicioPorHabitacion
    t = Time.now
    estadoCuentaMes = EstadoCuentaServicio.new(Time.now, calcularPagoServicioPorHabitacion,"Pago por concepto de servicios", "Pendiente")
    for h in arregloHabitaciones
      h.registrarEstadoCuentaServicio(estadoCuentaMes)
    end
  end
end