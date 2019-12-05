require_relative '../../app/model/factory/UsuarioFactory'
require_relative '../../app/model/entity/Habitacion'

class PropietarioRepository

  def initialize()

  end

  def cargarPropietarios()

    auxUsuarios = []

    usuarioPropietario1 = UsuarioFactory.create('Propietario', 'Pedro', 'Aquino', '12346578')
    usuarioPropietario2 = UsuarioFactory.create('Propietario', 'Juan', 'Ortiz', '76096607')
    usuarioPropietario3 = UsuarioFactory.create('Propietario', 'Leticia', 'Alvarez', '69696969')

    habitacion1 = Habitacion.new(101, usuarioPropietario1,Time.new)
    habitacion2 = Habitacion.new(102, usuarioPropietario2,Time.new)
    habitacion3 = Habitacion.new(201, usuarioPropietario3,Time.new)

    usuarioPropietario1.asignarHabitacion(habitacion1)
    usuarioPropietario2.asignarHabitacion(habitacion2)
    usuarioPropietario3.asignarHabitacion(habitacion3)

    auxUsuarios.push(usuarioPropietario1)
    auxUsuarios.push(usuarioPropietario2)
    auxUsuarios.push(usuarioPropietario3)

    return auxUsuarios

  end

  def buscarDatosPropietario(nombre,dni)
    raise "Datos nulos" if nombre == "" && dni == ""

    usuarios = cargarPropietarios
    usuarioAux = nil

    usuarios.each do |u|
      if u.nombre == nombre && u.dni == dni
        usuarioAux = u
      end
    end

    raise "No existe propietario" if usuarioAux == nil

    return usuarioAux
  end
end