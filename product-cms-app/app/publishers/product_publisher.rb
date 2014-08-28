class ProductPublisher
  def self.upsert(product)
    # TODO: Your code goes here!
  end

  def self.destroy(product)
    # TODO: Your code goes here!
  end

  def self.conn
    ::RABBITMQ_CONN
  end
end
