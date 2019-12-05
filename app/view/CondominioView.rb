require_relative '../../app/utils/ValidationUtils'
require_relative '../../app/model/entity/Condominio'
require_relative '../../app/model/entity/Servicio'
require_relative '../../app/model/entity/Visita'
require_relative '../../app/model/entity/Visitante'
require_relative 'BaseView'

class CondominioView < BaseView

  attr_accessor :validationUtil, :condominio

  def initialize
    @validationUtil = ValidationUtil.new
    @condominio = nil
  end


  def mostrar_opciones(usuario)

    opciones_administrador = ['1', '2', '3']
    opciones_propietario = ['1', '2', '3']

    show_message('================================')
    show_message('Menú de opciones')

    case usuario.tipo
    when 'Administrador'
      show_message('1 - Registrar condominio')
      show_message('2 - Seleccionar condominio')
      show_message('3 - Salir')
    when 'Propietario'
      show_message('1 - Registrar Familiar')
      show_message('2 - Mostrar datos propietario')
      show_message('3 - Salir')
    end


    opcion = gets.chomp

    case usuario.tipo
    when 'Administrador'
      raise show_message('Admin no tiene estas opciones') if !opciones_administrador.include? opcion
    when 'Propietario'
      raise show_message('Propietario no tiene estas opciones') if !opciones_propietario.include? opcion
    end
    return opcion
  end

  def mostrar_registro_condominio()
    limpiarConsola

    show_message('================================')
    show_message('Registro de condominio')
    show_message('================================')
    show_message('Ingresa el nombre del Condominio:')
    show_message('')

    nombreCondominio = gets.chomp
    return Condominio.new(nombreCondominio)


  end

  def mostrar_condominios(usuario)
    show_message('================================')
    show_message('Condominios disponibles')
    show_message('================================')
    arregloIds = []
    usuario.arregloCondominios.each do |condominio|
      show_message("Código: #{condominio.id}, condominio: #{condominio.nombre}")
      arregloIds << condominio.id
    end

    codCondominio = nil

    while codCondominio == nil || !arregloIds.include?(codCondominio)
      puts "Seleccione un código válido"
      codCondominio = gets.chomp.to_i
    end
    usuario.arregloCondominios.each do |c|
      if c.id == codCondominio
        self.condominio = c
      end
    end
    # puts "dentro de condo" + self.condominio.arregloHabitaciones[0].numeroHabitacion.to_s
    limpiarConsola
    return self.condominio
  end

  def mostrarOpcionesCondominio
    opcion = nil
    show_message('================================')
    show_message('Menú de opciones')
    show_message('1 - Registrar habitacion')
    show_message('2 - Registrar servicio')
    show_message('3 - Registrar visita')
    show_message('4 - Generar estado cuentas servicio por habitacion')
    show_message('5 - Registrar pago por concepto de Servicios por habitacion')
    show_message('6 - Consultar visitas por fechas')
    show_message('7 - Consultar visitas por rango de fechas')
    show_message('8 - Consultar visitas por numero de habitacion')
    show_message('9 - Consultar pagos de servicio por habitacion')
    show_message('10 - Consultar pagos de servicio por DNI')
    show_message('11 - Consultar deudores de los servicios')
    show_message('12 - Regresar')

    while opcion == nil || opcion < 1 || opcion > 12
      puts "Seleccione una opcion válida"
      opcion = gets.chomp.to_i
    end
    return opcion

  end

  def mostrarHabitacionesDisponibles
    habDisponibles = []
    show_message('================================')
    show_message('Habitaciones disponibles')
    show_message('================================')
    self.condominio.arregloHabitaciones.each do |h|
      if h.isDisponible == true
        show_message("Numero habitacion: #{h.numeroHabitacion}, Estado: Disponible")
        habDisponibles << h.numeroHabitacion
      end
    end
    numHabitacion = nil

    while numHabitacion == nil || !habDisponibles.include?(numHabitacion)
      puts "Seleccione una numero de habitacion válido"
      numHabitacion = gets.chomp.to_i
    end
    habitacionAux = nil
    self.condominio.arregloHabitaciones.each do |h|
      if h.numeroHabitacion == numHabitacion
          habitacionAux = h
      end
    end

    return habitacionAux

  end

  def mostrarHabitacionesOcupadas
    habDisponibles = []
    show_message('================================')
    show_message('Habitaciones ocupadas')
    show_message('================================')
    self.condominio.arregloHabitaciones.each do |h|
      if h.isDisponible == false
        show_message("Numero habitacion: #{h.numeroHabitacion}, Estado: Disponible")
        habDisponibles << h.numeroHabitacion
      end
    end
    numHabitacion = nil

    while numHabitacion == nil || !habDisponibles.include?(numHabitacion)
      puts "Seleccione una numero de habitacion válido"
      numHabitacion = gets.chomp.to_i
    end
    habitacionAux = nil
    self.condominio.arregloHabitaciones.each do |h|
      if h.numeroHabitacion == numHabitacion
        habitacionAux = h
      end
    end

    return habitacionAux

  end
  def mostrarRegistroHabitacion(habitacion)
    limpiarConsola

    show_message('================================')
    show_message('Registro de habitacion')
    show_message('================================')
    show_message('Ingresa el propietario:')
    show_message('')
    show_message('Nombre:')
    nombrePropietario = gets.chomp
    show_message('Apellido:')
    apellidoPropietario = gets.chomp
    show_message('DNI:')
    dniPropietario = gets.chomp
    propietario = UsuarioFactory.create("Propietario",nombrePropietario, apellidoPropietario,dniPropietario)
    habitacion.registrarPropietario(propietario)
    propietario.asignarHabitacion(habitacion)
    limpiarConsola
    return

  end

  def mostrarRegistroServicio
    limpiarConsola
    show_message('================================')
    show_message('Registro de Servicio')
    show_message('================================')
    show_message('')
    show_message('Nombre:')
    nombreServicio = gets.chomp
    show_message('Costo:')
    costoServicio = gets.chomp.to_f
    servicio = Servicio.new(nombreServicio,costoServicio)
    limpiarConsola
    show_message("\nNombre servicio: #{servicio.nombre}, costo: #{servicio.costo.to_s}")
    show_message("Registrado")
    show_message("\n\nPresione una enter para continuar")
    get.chomp
    limpiarConsola
    return servicio
  end

  def mostrarRegistroVisita(habitacion)
    limpiarConsola
    show_message('================================')
    show_message('Registro de Visita')
    show_message('================================')
    show_message('')
    show_message('Nombre:')
    nombreVisita = gets.chomp
    show_message('Apellidos:')
    apellidosVisita = gets.chomp
    show_message('DNI:')
    dniVisita = gets.chomp
    visitante = Visitante.new("Visitante",nombreVisita,apellidosVisita,dniVisita)
    fecha = mostrarConsultaVisitasPorFecha
    visita = Visita.new(fecha,habitacion)
    visita.registrarVisitante(visitante)
    limpiarConsola
    show_message("\nVisita: nombre: #{visitante.nombre}, fecha: #{visita.fecha}")
    show_message("Registrado")
    return visita
  end

  def mostrarGeneracionEstadoCuentaServicio(usuario)
    limpiarConsola
    show_message('================================')
    show_message('Se estan generando los estados de cuenta para pago de Servicios')
    show_message('================================')
    show_message('')
    cuenta = usuario.registrarCuentasPagoServicioPorHabitacion(condominio)
    show_message("Cuenta por habitacion: fechaGeneracion: #{cuenta.fecha}, Cargo: #{cuenta.cargo}")
  end

  def mostrarCuentas(habitacion)
    cuentas = []
    show_message('================================')
    show_message('Cuentas pendientes')
    show_message('================================')
    habitacion.arregloEstadoCuenta.each do |e|
      if e.estadoPago == "Pendiente"
        show_message("Cuenta codigo: #{e.id}, fecha: #{e.fecha}, cargo: #{e.cargo}, Estado: Pendiente")
        cuentas << e.id
      end
    end
    id = nil

    while id == nil || !cuentas.include?(id)
      puts "Seleccione una codigo de estado cuenta válido para pagar"
      id = gets.chomp
    end
    cuentaAux = nil
    habitacion.arregloEstadoCuenta.each do |h|
      if h.id == id
        cuentaAux = h
      end
    end

    return cuentaAux
  end

  def mostrarPagoCuenta(estadiCuenta)
    show_message('================================')
    show_message('Desea cancelarlo? Escriba Y(Si) o N(No)')
    show_message('================================')
    resultado = nil
    while resultado == nil || resultado != "Y" || resultado != "N"
      puts "Seleccione una opcion válido"
      resultado = gets.chomp
    end
    if resultado == "Y"
      return true
    else
      return false
    end
  end

  def mostrarTransaccionIncorrecta
    show_message('================================')
    show_message('No se logro registrar pago')
    show_message('================================')
  end

  def mostrarConsultaVisitasPorFecha
    show_message('================================')
    show_message('Ingrese fecha en el siguiente formato dd/mm/yyyy')
    show_message('================================')
    fechaTiempo = nil
    while fechaTiempo == nil
      begin
        fecha = gets.chomp
        fechaTiempo = validarFormato(fecha)
      rescue Exception => e
        puts "Formato incorrecto, ingrese nuevamente"
      end
    end
    return fechaTiempo

  end

  def validarFormato(fecha)
    arrayFecha = fecha.split('/')
    return Time.new(arrayFecha[2],arrayFecha[1],arrayFecha[0])

  end

  def mostrarVisitas(visitas)
    show_message('================================')
    show_message('Visitas encontradas')
    show_message('================================')
    visitas.each do |visita|
      show_message("Visita: fecha: #{visita.fecha}, habitacion: #{visita.habitacion.numeroHabitacion}")
      visita.arregloVisitantes.each do |visitante|
        show_message("\tVisitantes: nombre: #{visitante.nombre}, apellido: #{visitante.apellidos}")
      end
    end
  end

  def mostrarConsultaFechaInicio
    show_message('================================')
    show_message('CONSULTA DE VISITAS POR RANGO DE FECHA')
    show_message('Ingrese fecha inicio en el siguiente formato dd/mm/yyyy')
    show_message('================================')

    fechaTiempo = nil
    while fechaTiempo == nil
      begin
        fecha = gets.chomp
        fechaTiempo = validarFormato(fecha)
      rescue Exception => e
        puts "Formato incorrecto, ingrese nuevamente"
      end
    end
    return fechaTiempo

  end

  def mostrarConsultaFechaFin
    show_message('================================')
    show_message('Ingrese fecha fin en el siguiente formato dd/mm/yyyy')
    show_message('================================')

    fechaTiempo = nil
    while fechaTiempo == nil
      begin
        fecha = gets.chomp
        fechaTiempo = validarFormato(fecha)
      rescue Exception => e
        puts "Formato incorrecto, ingrese nuevamente"
      end
    end
    return fechaTiempo

  end

  def mostrarDeudores(deudores)
    show_message('================================')
    show_message('Propietarios deudores')
    show_message('================================')
    deudores.each do |deudor|
      show_message("Deudor nombre: #{deudor.nombre}, apellido: #{deudor.apellidos}, dni: #{deudor.dni}")
    end
  end

  def mostrarConsultaPagoPorDNI
    show_message('================================')
    show_message('Ingrese el dni')
    show_message('================================')
    dni = gets.chomp
    return dni
  end

  def mostrarEstadoCuentas(cuentas)
    for c in cuentas
      show_message("Cuenta codigo: #{c.id}, fecha: #{c.fecha}, cargo: #{c.cargo}, Estado: #{c.estadoPago}")
    end
  end

  def mostrarRegistroFamiliar
    limpiarConsola

    show_message('================================')
    show_message('Registro de Familiar')
    show_message('================================')
    show_message('')
    show_message('Nombre:')
    nombreFamiliar = gets.chomp
    show_message('Apellido:')
    apellidoFamiliar = gets.chomp
    show_message('DNI:')
    dniFamiliar = gets.chomp
    familiar = Persona.new("Familiar",nombreFamiliar, apellidoFamiliar,dniFamiliar)
    limpiarConsola
    return familiar

  end

  def mostrarDatosPropietario(usuario)
    limpiarConsola

    show_message('================================')
    show_message('Mostrando datos de propietario')
    show_message('================================')
    show_message("\n")
    show_message("Habitacion #{usuario.habitacion.numeroHabitacion}")
    show_message("Datos de familiares:")
    for h in usuario.habitacion.arregloFamiliares
      show_message("\tNombre: #{h.nombre} Apellido: #{h.apellidos} DNI: #{h.dni}")
    end
    show_message("\nPresione enter para coninuar")
    gets.chomp
  end
end