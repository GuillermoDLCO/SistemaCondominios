require 'singleton'

class ValidationUtil

    def initialize

    end

    def validarFormatoFecha(input)
        valida = input[/^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/] == input
        raise "Formato de fecha incorrecto o fecha ingresada no válida. (dd/mm/yyyy)" if !valida
        return true
    end

    def validarDNI(input)
        valida = input[/[0-9]{8}+/] == input
        raise "Formato de DNI ingresado incorrecto. Solo 8 dígitos." if !valida
        return true
    end

end