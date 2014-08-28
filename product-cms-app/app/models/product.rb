class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :views
  validates :name, uniqueness: true

  after_save :publish_update
  after_destroy :publish_destroy

  private
    def publish_upsert
      ProductPublisher.upsert(self)
    end

    def publish_destroy
      ProductPublisher.destroy(self)
    end
end
