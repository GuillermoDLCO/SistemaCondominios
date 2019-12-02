require 'test/unit'
require_relative '../app/repositories/UsuarioRepository'


class LoginTest < Test::Unit::TestCase

  def test_validar_datos
    nombre = 'Guillermo'
    clave = '76096606'

    repo = UsuarioRepository.new
    result = repo.validar_datos(nombre, clave)

    assert_equal nombre, result.nombre
    assert_equal clave, result.dni

  end

end