require_relative '../../app/utils/PrintUtil'

class BaseView

    def initialize

    end

    def show_message(message)
        PrintUtil.printMessage(message)
    end

    def mostrar_error
        PrintUtil.printMessage("Error, revise la información ingresada")
        show_message("Presione enter para continuar")
        gets.chomp
    end

    def limpiarConsola
        if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
            system('cls')
        else
            system('clear')
        end
    end

    def salir
        PrintUtil.printMessage("Exit")
    end

end