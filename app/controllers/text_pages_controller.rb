class TextPagesController < ApplicationController

  def show
    @page = TextPage.where(:id => params[:id]).first || TextPage.find_by_name(params[:id])
    @section = @page.section
    render text: @page.body, :layout => true
  end
end
