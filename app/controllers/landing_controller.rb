class LandingController < ApplicationController
    def index
        @products = Product.paginate(page: params[:page], per_page: 20).order('created_at DESC')
    end
end