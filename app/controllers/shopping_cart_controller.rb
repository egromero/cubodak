class ShoppingCartController < ApplicationController
    def add_to_bag
        if logged_in?
            if current_user.shopping_cart.nil?
                cart = current_user.create_shopping_cart(total_price: 0)
            else
                cart = current_user.shopping_cart
            end
            product = Product.find(params[:product_id])
            relation = ShoppingCartProduct.where(product_id: product.id, shopping_cart_id: cart.id)
            if relation.exists?
                relation.first.quantity+= params[:quantity].to_i
                relation.first.save
            else
                shc = ShoppingCartProduct.create(product_id: product.id, shopping_cart_id: cart.id, quantity: params[:quantity])
                shc.save
            end
                shoppingCartProducts = ShoppingCartProduct.where(shopping_cart_id: cart.id)
                data = []
                shoppingCartProducts.each do |shcp|
                    product = shcp.product
                    final_price = product.final_price.to_i*shcp.quantity
                    data.append({
                        "product" =>product,
                        "quantity" => shcp.quantity,
                        "image" => url_for(product.images[0]),
                        "total_price" => final_price
                })
                end
            return render json: {"msg": "Agregado a la bolsa", "status": 200, "data": data}
        else
            return render json: {"error": "Usuario no registrado"}
        end
    end
    def checkout
        cart = current_user.shopping_cart
        @shoppingCartProducts = ShoppingCartProduct.where(shopping_cart_id: cart.id)
        @final_price = 0
        @shoppingCartProducts.each do |product|
            @final_price += product.quantity * product.product.final_price.to_i
        end
    end

    def get_shopping_cart
        if current_user.shopping_cart.nil?
            return render json: {"msg": "no hay productos enla bolsa", "data": []}
        else
            shoppingCartProducts = ShoppingCartProduct.where(shopping_cart_id: current_user.shopping_cart.id)
            data = []
            shoppingCartProducts.each do |shcp|
                product = shcp.product
                final_price = product.final_price.to_i*shcp.quantity
                data.append({
                    "product" => product,
                    "quantity" => shcp.quantity,
                    "image" => url_for(product.images[0]),
                    "total_price" => final_price
                    })
            end
            return render json: {"msg": "", "status": 200, "data": data}
        end
    end
end
