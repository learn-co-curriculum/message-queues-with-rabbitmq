class ProductConsumer
  attr_accessor :conn

  def initialize(conn)
    @conn = conn
  end

  def start
    subscribe_to_upsert
    subscribe_to_destroy
  end

  def subscribe_to_upsert
    # TODO: Your code goes here!
  end

  def subscribe_to_destroy
    # TODO: Your code goes here!
  end
end
