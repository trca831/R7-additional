require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create(:order)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "get orders_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
  end
    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000)
      expect(response).to redirect_to orders_path
      end
  end

  describe "gets new_order_path" do
    it "renders the :new template" do
      order = FactoryBot.create(:order)
      get new_order_path(id: order.id)
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end
#customers
describe "post order_path with valid data" do
  it "saves a new entry and redirects to the show path for the entry" do
    customer = FactoryBot.create(:customer)
    order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
    expect { post orders_path, params: {order: order_attributes} }.to change(Order, :count)
    expect(response).to redirect_to order_path(id: Order.last.id)
  end
end
describe "post orders_path with invalid data" do
  it "does not save a new entry or redirect" do
    customer = FactoryBot.create(:customer)
    order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
    order_attributes.delete(:product_name)
    expect {post orders_path, params: {order: order_attributes} }.to_not change(Order, :count)
    expect(response).to render_template(:new)
  end
end

#orders
  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end

  describe "delete an order record" do
    it "deletes an order record" do
      order = FactoryBot.create(:order)
      expect { delete order_path(order.id) }.to change(Order, :count)
      expect(response).to redirect_to orders_path
    end
  end

end
