class ProductConsumer
  attr_accessor :conn

  def initialize(conn)
    @conn = conn
  end

  def start
    subscribe_to_upsert
    subscribe_to_destroy
  end

  def stop
    channel.close
  end

  def subscribe_to_upsert
    product_upsert_queue.subscribe(&product_upsert_handler)
  end

  def subscribe_to_destroy
    product_destroy_queue.subscribe(&product_destroy_handler)
  end

  def product_upsert_handler
    lambda do |delivery_info, properties, payload|
    puts 'Handling product upsert...'
      data = JSON.parse(payload)
      product = Product.find_or_initialize_by(name: data['name'])
      puts "[consumer] #{product_upsert_queue.name} updating product #{product.name}"
      puts data
      product.update!(
        description: data['description'],
        price: data['price'].to_i
      )
      puts 'done'
    end
  end

  def product_destroy_handler
    lambda do |delivery_info, properties, payload|
    puts 'Handling product destroy...'
      data = JSON.parse(payload)
      product = Product.find_by!(name: data['name'])
      puts "[consumer] #{product_destroy_queue.name} destroying product #{product.name}"
      puts data
      product.destroy
      puts 'done'
    end
  end

  def product_destroy_queue
    @product_destroy_queue ||=
      channel.queue("product_upsert", durable: true).bind(exchange, routing_key: 'product_destroy')
  end

  def product_upsert_queue
    @product_write_queue ||=
      channel.queue("product_destroy", durable: true).bind(exchange, routing_key: 'product_upsert')
  end

  def channel
    @channel ||= conn.create_channel
  end

  def exchange
    @exchange ||= channel.direct("products", durable: true)
  end
end
