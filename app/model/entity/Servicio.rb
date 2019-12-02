class Servicio
  @@id_static = 0
  attr_accessor :id, :nombre, :costo
  def initialize(nombre, costo)
    @@id_static += 1
    @id = @@id_static
    @nombre, @costo = nombre, costo
  end
end