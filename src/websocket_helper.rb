require 'digest/sha1'

module WebSocketHelper
  class << self

    # Extract key from header
    def get_websocket_key header
      return header.match(/^Sec-WebSocket-Key: (\S+)/)[1]
    end

    # Tem=plate for header 
    def prepare_header response_key
      socket.write <<-eos.gsub(/\s+/, " ").strip
        HTTP/1.1 101 Switching Protocols
        Upgrade: websocket
        Connection: Upgrade
        Sec-WebSocket-Accept: #{ response_key }

        eos
    end

    def generate_new_key(key, string = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11')
      Digest::SHA1.base64digest([key, string ].join)
    end
  end
end
