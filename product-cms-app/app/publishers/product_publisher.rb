class ProductPublisher
  def self.upsert(product)
    ch = conn.create_channel
    exchange = ch.direct('products', durable: true)
    exchange.publish(product.attributes.to_json, routing_key: 'product_upsert')
    ch.close
  end

  def self.destroy(product)
    ch = conn.create_channel
    exchange = ch.direct('products', durable: true)
    exchange.publish(product.attributes.to_json, routing_key: 'product_destroy')
    ch.close
  end

  def self.conn
    ::RABBITMQ_CONN
  end
end
