class Persona
  @@id_static = 0
  attr_accessor :id, :tipo, :nombre, :apellidos, :dni
  def initialize(tipo, nombre, apellidos, dni)
    @@id_static += 1
    @id = @@id_static
    @tipo, @nombre, @apellidos, @dni =  tipo, nombre, apellidos, dni
  end

end