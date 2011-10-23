class SectionsController < ApplicationController
  # Render this layout
  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_page
  
  def index
    list
    render('list')
  end
  
  
  def list
    @sections = Section.order("sections.position ASC").where(:page_id => @page.id)
  end
  
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new(:page_id => @page.id)
    @section_count = @page.sections.size + 1
    @pages = Page.order('position ASC')
  end
  
  
  def create
    # instantiates new Section object based on form params
    @section = Section.new(params[:section])
    
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(:action => 'list', :page_id => @section.page_id )
    else
      flash.now[:notice] = "Create failed - you need to enter a name"
      @section_count = Section.count + 1
      render('new')
    end
  end
  
  
  
  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @pages = Page.order('position ASC')
  end
  
  
  def update
    @section = Section.find(params[:id])     
    
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section update successful."
      redirect_to(:action => 'list', :page_id => @section.page_id )
    else
      flash[:notice] = "Update did not succeed - you need to enter a name"
      @section_count = Section.count
      render('edit')
    end
  end
  
  
  def delete
    @section = Section.find(params[:id])
    render('delete')
  end
  
  
  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section Destroyed successfully"
    redirect_to(:action => 'list', :page_id => @section.page_id )    
  end
  
  
  private
  
  def find_page
   if params[:page_id]
    @page = Page.find_by_id(params[:page_id])
   end   
  end
  
  
  
  
end
