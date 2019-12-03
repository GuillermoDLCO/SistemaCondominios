require_relative 'BaseView'

class LoginView < BaseView

  def initialize

  end

  def mostrar_login
    limpiarConsola
    datos = []
    show_message('===================================')
    show_message('Login')
    show_message('===================================')
    show_message('Ingresa tu usuario:')

    usuario = gets.chomp
    datos.push(usuario)
    show_message('Ingresa tu contraseña:')
    contrasena = gets.chomp

    datos.push(contrasena)

    return datos
  end

end