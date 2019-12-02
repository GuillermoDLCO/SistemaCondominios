require 'singleton'
require_relative 'LoginTest'

class AppTest
  include Singleton

  def init
    LoginTest.new('test_validar_datos')
  end

end


app = AppTest.instance
app.init