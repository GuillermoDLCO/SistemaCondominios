require_relative 'Persona'

class Visitante < Persona

  def initialize(tipo, nombre, apellidos, dni)
    super(tipo, nombre, apellidos, dni)

  end
end