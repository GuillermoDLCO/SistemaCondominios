require_relative '../entity/EstadoCuentaServicio'

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
      puts "costos " + s.costo.to_s
      totalServicio += s.costo
    end
    cantidadHabitacionesOcupadas = 0
    for h in arregloHabitaciones
      if h.isDisponible == false
        cantidadHabitacionesOcupadas += 1
      end
    end
    pagoPorHabitacion = (totalServicio * 1.0 / cantidadHabitacionesOcupadas).round(2)

    return pagoPorHabitacion
  end

  def generarCuentasServicioPorHabitacion
    t = Time.now

    for h in arregloHabitaciones
      if h.isDisponible == false
        estadoCuentaMes = EstadoCuentaServicio.new(Time.now, calcularPagoServicioPorHabitacion,"Pago por concepto de servicios", "Pendiente")
        h.registrarEstadoCuentaServicio(estadoCuentaMes)
      end
    end
    return EstadoCuentaServicio.new(Time.now, calcularPagoServicioPorHabitacion,"Pago por concepto de servicios", "Pendiente")
  end

  def registrarPagoServicioHabitacion(habitacion, estadoCuenta)
    habitacion.pagarEstadoCuenta(estadoCuenta)
  end
end