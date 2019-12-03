require_relative '../../app/repositories/UsuarioRepository'
require_relative '../../app/controller/CondominioControlador'
require_relative '../../app/view/CondominioView'

class LoginControlador

  attr_accessor :vista, :usuarios

  def initialize(vista)
    @vista = vista
    @usuarios = []
  end

  def mostrar_logueo
    datos = vista.mostrar_login
    repo = UsuarioRepository.new

    begin
      usuario = repo.validar_datos(datos[0], datos[1])
      condominio = CondominioControlador.new(CondominioView.new, usuario)
      condominio.mostrar_opciones
    rescue Exception => e
      vista.mostrar_error
    end

  end

end