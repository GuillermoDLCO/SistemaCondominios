require_relative 'Persona'

class UsuarioPropietario < Persona
  attr_accessor :habitacion
  def initialize(tipo, nombre, apellidos, dni)
    super(tipo, nombre, apellidos, dni)
    @habitacion = nil
  end

  def registrarFamiliarHabitacion(familiar)
    habitacion.registrarFamiliar(familiar)
  end

  def asignarHabitacion(habitacion)
    self.habitacion = habitacion
  end
end