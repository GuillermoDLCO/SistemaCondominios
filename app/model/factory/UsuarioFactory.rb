require_relative '../../../app/model/entity/UsuarioAdministrador'
require_relative '../../../app/model/entity/UsuarioPropietario'

class UsuarioFactory

  def self.create(tipo, *argumentos)
    case tipo
    when 'Administrador'
      UsuarioAdministrador.new(tipo, *argumentos[0], *argumentos[1], *argumentos[2])
    when 'Propietario'
      UsuarioPropietario.new(tipo, *argumentos[0], *argumentos[1], *argumentos[2])
    end
  end
end
