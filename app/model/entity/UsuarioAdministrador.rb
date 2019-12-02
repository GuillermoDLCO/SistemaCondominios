require_relative 'Persona'

class UsuarioAdministrador < Persona
  attr_accessor :arregloCondominios
  def initialize(tipo, nombre, apellidos, dni)
    super(tipo, nombre, apellidos, dni)
    @arregloCondominios = []
  end

  def registrarCondominio(condominio)
    arregloCondominios << condominio
  end

  def registrarServicio(condominio, servicio)
    condominio.registarServicio(servicio)
  end

  def registrarHabitacionCondominio(condominio, habitacion)
    habitacion.propietario.asignarHabitacion(habitacion)
    condominio.registrarHabitacion(habitacion)
  end

  def registrarPagoServicioPorHabitacion(condominio)
    condominio.generarCuentasServicioPorHabitacion
  end

  def obtenerVisitasPorFecha(condominio, fecha)
    arregloVisitasEncontradas = []
    fecha = fecha.strftime('%d:%m:%Y')
    for v in condominio.arregloVisitas
      fechaVisita = v.fecha.strftime('%d:%m:%Y')
      if fecha == fechaVisita
        arregloVisitasEncontradas << v
      end
    end
    return arregloVisitasEncontradas
  end

  def obtenerVisitasPorRangoFecha(condominio, fechaInicio, fechaFin)
    arregloVisitasEncontradas = []
    for v in condominio.arregloVisitas
      if v.fecha.between?(fechaInicio,fechaFin)
        arregloVisitasEncontradas << v
      end
    end

    raise "No existen visitas" if arregloVisitasEncontradas.empty?

    return arregloVisitasEncontradas
  end

  def obtenerPagoServiciosPorDNI(condominio, dni)
    for h in condominio
      if h.propietario.dni == dni
        return h.arregloEstadoCuenta
      end
    end
  end

  def consultaPagoServiciosPorHabitacion(numeroHabitacion)
    for h in condominio
      if h.numeroHabitacion == numeroHabitacion
        return h.arregloEstadoCuenta
      end
    end
  end

  def consultaDeudoresServicios(condominio)
    arregloDeudores = []
    for h in condominio
      for ec in h.arregloEstadoCuenta
        if ec.estadoPago == "Pendiente"
          arregloDeudores << h.propietario
          break
        end
      end
    end
    return arregloDeudores
  end

end