require 'spec_helper'

describe 'product writes' do
  let(:product_name) { 'Copper Wire' }
  let(:price) { 5 }
  let(:description) do
<<-DESC
Bare Copper Wire 18 SWG 1b, Sold wound on a Spool or in a Roll, depending upon the thickness of the wire. Picture is for display purpose only.
Picture is a representation of spool, please refer to product description for dimensions and specifications.
Measurements are approximate.
DESC
  end

  before do
    visit('http://localhost:9292/products/new')
    fill_in('Name', with: product_name)
    fill_in('Description', with: description)
    fill_in('Price', with: price)
    click_button 'Create'
    sleep 0.1
  end

  describe 'CMS creation' do
    it 'creates a new product on Sales' do
      visit('http://localhost:9293/products')
      expect(page).to have_content(product_name)
    end
  end

  describe 'CMS update' do
    it 'updates the product on Sales' do
      visit("http://localhost:9292/products")
      click_on(product_name)
      fill_in('Name', with: product_name+'!')
      click_button 'Update'
      sleep 0.1

      visit('http://localhost:9293/products')
      expect(page).to have_content(product_name+'!')
    end
  end

  describe 'CMS destroy' do
    it 'destroys the product on Sales' do
      visit('http://localhost:9293/products')
      expect(page).to have_content(product_name)

      visit("http://localhost:9292/products")
      click_on(product_name)
      click_button 'DELETE PRODUCT'
      sleep 0.1

      visit('http://localhost:9293/products')
      expect(page).to_not have_content(product_name)
    end
  end

  describe 'rabbitmq' do
    let(:conn) { Bunny.new.start }
    let(:channel) { conn.create_channel }

    describe 'product_upsert queue' do
      it 'exists' do
        expect(conn.queue_exists?('product_upsert')).to eq true
      end

      # To see this in action, start up CMS with the rackup command
      # and perform some CRUD operations. Go to http://localhost:15672
      # and look at your queue, the messages should be waiting there.
      # Bring Sales back online and the messages should be processed off
      # the queue.
      it 'is durable' do
        expect(conn.queue_exists?('product_upsert')).to eq true
        q = channel.queue('product_upsert', durable: true) rescue nil
        expect(q).to be
        expect(q).to be_durable
      end
    end

    describe 'product_destroy queue' do
      it 'exists' do
        expect(conn.queue_exists?('product_destroy')).to eq true
      end

      # To see this in action, start up CMS with the rackup command
      # and perform some CRUD operations. Go to http://localhost:15672
      # and look at your queue, the messages should be waiting there.
      # Bring Sales back online and the messages should be processed off
      # the queue.
      it 'is durable' do
        expect(conn.queue_exists?('product_destroy')).to eq true
        q = channel.queue('product_destroy', durable: true) rescue nil
        expect(q).to be
        expect(q).to be_durable
      end
    end
  end
end
