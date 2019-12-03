
require_relative '../../app/model/entity/Habitacion'

class HabitacionRepository

  def initialize()

  end

  def cargarHabitaciones()

    auxHabitaciones = []

    habitacion1 = Habitacion.new(101,nil, nil)
    habitacion2 = Habitacion.new(102,nil, nil)
    habitacion3 = Habitacion.new(201,nil, nil)
    habitacion4 = Habitacion.new(202,nil, nil)

    auxHabitaciones.push(habitacion1)
    auxHabitaciones.push(habitacion2)
    auxHabitaciones.push(habitacion3)
    auxHabitaciones.push(habitacion4)

    return auxHabitaciones

  end

end