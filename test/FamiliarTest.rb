require 'test/unit'
require_relative '../app/repositories/UsuarioRepository'


class LoginTest < Test::Unit::TestCase

  def test_validar_datos
    repo = UsuarioRepository.new

    nombre = 'Pedro'
    clave = '12346578'


	begin
    result = repo.validar_datos(nombre, clave)
    habitacion = Habitacion.new(101,result,Time.new)
    result.asignarHabitacion(habitacion)
    puts result.habitacion.numeroHabitacion
    familiar = Persona.new("Familiar","Juan","Arredondo","98759222")
    result.registrarFamiliarHabitacion(familiar)
    habitacion.arregloFamiliares
    for i in habitacion.arregloFamiliares
    	puts i.nombre
    end
    raise "No hay familiares registrados" if habitacion.arregloFamiliares.empty?

    for f in habitacion.arregloFamiliares
    	puts "Familiar  nombre: #{f.nombre} apellido #{f.apellidos} dni: #{f.dni}"
	end
    
	rescue Exception => e
		puts e.message +  " lol"
		puts e.backtrace
	end

    assert_equal habitacion.arregloFamiliares[0].nombre, familiar.nombre
    assert_equal habitacion.arregloFamiliares[0].dni, familiar.dni

  end

end