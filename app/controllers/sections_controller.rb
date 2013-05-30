class SectionsController < ApplicationController
  def show
    @section = (params[:id] || params[:section_id] ? Section.find_by_name(params[:id] || params[:section_id]) : nil)
    @page_number = [(params[:page] || '1').to_i, 1].max - 1
    if !@section
      render 'main_page/not_found'
    elsif @section.main?
      redirect_to root_path
    else
      @page = TextPage.find_all_by_section_id(@section.id).first
      render
    end
  end
end
