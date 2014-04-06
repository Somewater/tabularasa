# encoding: utf-8

class SectionsController < ApplicationController
  def show
    @section = Section.find_by_name(params[:id])
    @products = @section.products
    render 'products/index'
  end
end