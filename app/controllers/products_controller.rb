require 'csv'
class ProductsController < ApplicationController

  def list
    @products = furnitureitems

  end

  def detail
    @products = furnitureitems

     the_id = params[:id]

     @product = @products.find {|product| product.id == params[:id]}
  end

  def furnitureitems

    @products= []

    CSV.foreach(Rails.root + "data/mf_inventory_csv.csv", headers: true) do |row|


      if row.to_h["quantity"].to_i > 0
        product = Product.new
        product.id = row.to_h["pid"]
        product.item = row.to_h["item"]
        product.description = row.to_h["description"]
        product.price = row.to_h["price"]
        product.condition = row.to_h["condition"]
        product.dimension_w = row.to_h["dimension_w"]
        product.dimension_l = row.to_h["dimension_l"]
        product.dimension_h = row.to_h["dimension_h"]
        product.img_name = row.to_h["img_name"]
        product.quantity = row.to_h["quantity"]
        product.category = row.to_h["category"]

        @products << product
      end
    end 
    @products
  end
end
