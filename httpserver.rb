require "socket"

server = TCPServer.new(2000)

def read_request(client)
  lines = []
  while raw_input = client.gets
    line = raw_input.chomp if raw_input
    lines << line
    p line
    if line.empty?
      x = lines.first.split(" ")
      path = x[1].split("?")[0]
      return {
        verb: x[0],
        path: path,
        protocol: x[2]
      }
    end
  end
end

def handle_request(request, &block)
  response = { body: "", status: "404 Not Found" }
  if request[:path] == "/test"
    response[:status] = "200 OK"
    response[:body] = "hooray!"
  end
  yield response
end

loop do
  client = server.accept
  request = read_request(client)
  p request

  handle_request(request) do |response|
    client.puts "HTTP/1.1 #{response[:status]}"
    client.puts "Content-Type: text/html"
    client.puts ""

    response[:body].split("\n").each do |line|
      client.puts line
    end
  end

  client.close
end