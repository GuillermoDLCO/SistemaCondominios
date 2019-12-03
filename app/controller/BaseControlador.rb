require_relative '../../app/utils/PrintUtil'

class BaseControlador

  def show_message(message)
    PrintUtil.printMessage(message)
  end

end