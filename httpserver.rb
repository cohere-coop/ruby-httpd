require 'socket'

server = TCPServer.new 2000

loop do
  client = server.accept #connection establishing between client and server
  while raw_input = client.gets  #client.gets is reading from the client
    line = raw_input.chomp if raw_input        
    if line.empty?
      client.puts "HTTP/1.1 200 OK"
      client.puts  ""
      client.puts "<h1>Hooray</h1>"
      client.close
      break
    end
  end
end
