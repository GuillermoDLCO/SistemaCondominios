require 'singleton'

require_relative 'app/controller/LoginControlador'
require_relative 'app/view/LoginView'
require_relative 'app/view/BaseView'


class AppConfig

  include Singleton

  def init

    controlador = LoginControlador.new(LoginView.new)
    controlador.mostrar_logueo

  end

end

app = AppConfig.instance
app.init
