require_relative '../../app/controller/BaseControlador'
require_relative '../../app/repositories/UsuarioRepository'

class CondominioControlador < BaseControlador

  attr_accessor :vista, :usuario

  def initialize(vista, usuario)
    @vista = vista
    @usuario = usuario
  end

  def mostrar_opciones
    begin
      vista.limpiarConsola
      opcion = vista.mostrar_opciones(usuario)
      realizar_opcion(opcion)
    rescue Exception => e
      show_message("#{e.message}")
      vista.mostrar_error
      mostrar_opciones
    end
  end


  def realizar_opcion(opcion)
    if usuario.tipo == "Administrador"
      case opcion
      when '1'

        begin
          condominio = vista.mostrar_registro_condominio
          usuario.registrarCondominio(condominio)
          usuario.registrarHabitacionCondominio(condominio)
          mostrar_opciones
        rescue Exception => e
          show_message("#{e.message}")
          puts e.backtrace
          vista.mostrar_error
        end
      when '2'
        condominio = vista.mostrar_condominios(usuario)
        listarMenuCondominio(condominio)

      when '3'
        vista.salir
      end
    else
      case opcion
      when '1'
        familiar = vista.mostrarRegistroFamiliar
        usuario.registrarFamiliarHabitacion(familiar)
        mostrar_opciones
      when '2'
        vista.mostrarDatosPropietario(usuario)
      when '3'
        vista.salir
      end

    end


  end

  def listarMenuCondominio(condominio)
    opcion = vista.mostrarOpcionesCondominio

    case opcion
    when 1 #registrar habitacion
      habitacion = vista.mostrarHabitacionesDisponibles
      vista.mostrarRegistroHabitacion(habitacion)
      puts condominio.arregloHabitaciones[0].propietario.habitacion.numeroHabitacion.to_s
      listarMenuCondominio(condominio)
    when 2 #Registrar servicio
      servicio = vista.mostrarRegistroServicio
      usuario.registrarServicio(condominio,servicio)
      listarMenuCondominio(condominio)
    when 3 #Registrar visita
      habitacion = vista.mostrarHabitacionesOcupadas
      visita = vista.mostrarRegistroVisita(habitacion)
      usuario.registrarVisita(condominio,visita)
      listarMenuCondominio(condominio)
    when 4 # Generar estado cuentas servicio por habitacion
      vista.mostrarGeneracionEstadoCuentaServicio(usuario)
      listarMenuCondominio(condominio)
    when 5 # Registrar pago por concepto de Servicios por habitacion
      habitacion = vista.mostrarHabitacionesOcupadas
      estadoCuenta = vista.mostrarCuentas(habitacion)
      if vista.mostrarPagoCuenta(estadoCuenta)
        usuario.registrarPagoServicioPorHabitacion(condominio, habitacion, estadoCuenta)
      else

      end
    when 6 # Consultar visitas por fechas'
      fecha = vista.mostrarConsultaVisitasPorFecha
      visitas = usuario.obtenerVisitasPorFecha(condominio,fecha)
      vista.mostrarVisitas(visitas)
      listarMenuCondominio(condominio)
    when 7 # Consultar visitas por rango de fechas
      fechaInicio = vista.mostrarConsultaFechaInicio
      fechaFin = vista.mostrarConsultaFechaFin
      visitas = usuario.obtenerVisitasPorRangoFecha(condominio,fechaInicio,fechaFin)
      vista.mostrarVisitas(visitas)
      listarMenuCondominio(condominio)
    when 8 # Consultar visitas por numero de habitacion
      habitacion = vista.mostrarHabitacionesOcupadas
      visitas = usuario.obtenerVisitasPorHabitacion(condominio,habitacion)
      vista.mostrarVisitas(visitas)
      listarMenuCondominio(condominio)
    when 9 # Consultar pagos de servicio por habitacion
      habitacion = vista.mostrarHabitacionesOcupadas
      estadoCuentas = usuario.consultaPagoServiciosPorHabitacion(condominio, habitacion.numeroHabitacion)
      if estadoCuentas != nil
        vista.mostrarEstadoCuentas(estadoCuentas)
      end
      listarMenuCondominio(condominio)
    when 10 # Consultar pagos de servicio por DNI
      dni = vista.mostrarConsultaPagoPorDNI
      estadoCuentas = usuario.obtenerPagoServiciosPorDNI(condominio, dni)
      if estadoCuentas != nil
         vista.mostrarEstadoCuentas(estadoCuentas)
      end
      listarMenuCondominio(condominio)
    when 11 # Consultar deudores de los servicios
      deudores = usuario.consultaDeudoresServicios(condominio)
      vista.mostrarDeudores(deudores)
      listarMenuCondominio(condominio)
    when 12 # Regresar
      mostrar_opciones
    end

  end

end