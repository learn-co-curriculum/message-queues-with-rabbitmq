tries = 0
begin
  RABBITMQ_CONN = Bunny.new.start
rescue Bunny::TCPConnectionFailed
  sleep 0.5
  tries += 1
  retry if tries < 5
end
