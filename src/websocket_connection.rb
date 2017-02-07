require 'socket'

# This class will be responsible to initialize connections and send messages
class WebSocketConnection
  def initialize
    @@server ||= TCPServer.new('localhost', 2345)
    @socket = nil
    @websocket_key = ''
    @response_key = ''
  end

  # Check if a client is waiting for a handshake, if it does create the
  # connection and return true or false depending if the connection was created
  # successfully
  # TODO: a better name for this function could be "start handshake" ...
  def check_for_clients
    return unless set_new_socket || set_websocket_key(read_header)
  end

  # Read the HTTP request.
  # Empty line with just \r\n means end of header
  def read_header
    http_request = ''
    while (line = @socket.gets) && (line != "\r\n")
      http_request += line
    end
  end

  # Check if there is any connection waiting to be open and  if it does
  # assing the TCPSocket
  def set_new_socket
    @socket = @server.accept_nonblock
  rescue IO::WaitReadable, Errno::EINTR
  end

  # Grab the security key from the headers.
  # If one isn't present, close the connection.
  # Assing the websocket key to websocket_key attribute
  def check_websocket_key(http_request)
    key = WebSocketHelper.get_websocket_key(http_request)
    if key
      @websocket_key = key
    else
      @socket.close
    end
  end

  def check_for_message; end

  def check_first_byte
    first_byte = @socket.getbyte
    fin = first_byte & 0b10000000
    opcode = first_byte & 0b00001111

    raise "We don't support continuations" unless fin
    raise 'We only support opcode 1' unless opcode == 1
  end

  def check_second_byte; end
end
