require 'time'
require_relative 'Persona'
require_relative '../../../app/repositories/HabitacionRepository'

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
    condominio.registrarServicio(servicio)
  end

  def registrarVisita(condominio, visita)
    condominio.registrarVisita(visita)
  end

  def registrarHabitacionCondominio(condominio)
    habitaciones = HabitacionRepository.new.cargarHabitaciones
    for h in habitaciones
      condominio.registrarHabitacion(h)
    end
  end

  def registrarHabitacionPropietario(habitacion, propietario)
    propietario.asignarHabitacion(habitacion)
    habitacion.registrarPropietario(propietario)
  end

  def liberarHabitacion(habitacion,propietario)
    propietario.habitacion = nil
    habitacion.propietario = nil
  end

  def registrarCuentasPagoServicioPorHabitacion(condominio)
    condominio.generarCuentasServicioPorHabitacion
  end

  def registrarPagoServicioPorHabitacion(condominio, habitacion, estadoCuenta)
    return condominio.registrarPagoServicioHabitacion(habitacion,estadoCuenta)
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

  def obtenerVisitasPorHabitacion(condominio,habitacion)
    for v in condominio.arregloVisitas
      if v.habitacion.numeroHabitacion == habitacion.numeroHabitacion
        arregloVisitasEncontradas << v
      end
    end
  end

  def obtenerPagoServiciosPorDNI(condominio, dni)
    for h in condominio
      if h.propietario.dni == dni
        return h.arregloEstadoCuenta
      end
    end
    return nil
  end

  def consultaPagoServiciosPorHabitacion(numeroHabitacion)
    for h in condominio
      if h.numeroHabitacion == numeroHabitacion
        return h.arregloEstadoCuenta
      end
    end
    return nil
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