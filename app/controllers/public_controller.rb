class PublicController < ApplicationController
  
  layout 'public'
  
  def index
    # intro text
  end

  def show
    @page = Page.where(:permalink => params[:id], :visible => true).first
    redirect_to(:action => 'index') unless @page
  end

end
