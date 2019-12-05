require_relative '../../app/model/factory/UsuarioFactory'

class UsuarioRepository

  def initialize()

  end

  def cargar_usuarios()

    auxUsuarios = []

    usuarioAdministrador = UsuarioFactory.create('Administrador', 'Guillermo', 'De La Cruz', '76096606')
    usuarioPropietario1 = UsuarioFactory.create('Propietario', 'Pedro', 'Aquino', '12346578')
    usuarioPropietario2 = UsuarioFactory.create('Propietario', 'Juan', 'Ortiz', '76096607')
    usuarioPropietario3 = UsuarioFactory.create('Propietario', 'Leticia', 'Alvarez', '69696969')

    auxUsuarios.push(usuarioAdministrador)
    auxUsuarios.push(usuarioPropietario1)
    auxUsuarios.push(usuarioPropietario2)
    auxUsuarios.push(usuarioPropietario3)

    return auxUsuarios

  end


  def validar_datos(usuario, contrasena)

    raise "Datos nulos" if usuario == "" && contrasena == ""

    usuarios = cargar_usuarios
    usuarioAux = nil

    usuarios.each do |u|
      if u.nombre == usuario && u.dni == contrasena
        usuarioAux = u
      end
    end

    raise "No existe usuario" if usuarioAux == nil

    return usuarioAux
  end

end