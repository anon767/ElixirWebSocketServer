defmodule Tom.GameServer.ReceiveMessage do
  defstruct left: 0,
            right: 0,
            action: 0,
            angle: 0
  def parseBinary(
        <<
          left ::  size(8),
          right ::  size(8),
          action ::  size(8),
          angle ::  size(8)
        >>
      ) do
    %Tom.GameServer.ReceiveMessage{left: left, right: right, action: action, angle: angle}
  end



end