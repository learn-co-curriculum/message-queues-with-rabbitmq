tries = 0
begin
  conn = Bunny.new.start
  ProductConsumer.new(conn).start
rescue Bunny::TCPConnectionFailed
  sleep 0.5
  tries += 1
  retry if tries < 20
end
