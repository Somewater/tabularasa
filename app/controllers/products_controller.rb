# encoding: utf-8

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_name(params[:id]) || Product.find_by_id(params[:id])
  end
end