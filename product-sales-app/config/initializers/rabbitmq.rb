conn = Bunny.new.start
ProductConsumer.new(conn).start
