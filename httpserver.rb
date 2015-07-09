require 'socket'

server = TCPServer.new 2000

loop do
  client = server.accept #connection establishing between client and server
  while line = client.gets.chomp  #client.gets is reading from the client
    p line
    if line == "exit"
      client.close
      break
    end
  end
end
