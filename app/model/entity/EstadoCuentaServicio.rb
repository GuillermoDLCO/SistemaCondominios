class EstadoCuentaServicio
  @@id_static = 0
  attr_accessor :id, :fecha, :cargo, :concepto, :estadoPago
  def initialize(fecha, cargo, concepto, estadoPago)
    @@id_static += 1
    @id = @@id_static
    @fecha, @cargo, @concepto, @estadoPago = fecha, cargo, concepto, estadoPago
  end

  def pagarCuenta
    estadoPago = "Pagado"
  end
end