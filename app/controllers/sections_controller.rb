class SectionsController < ApplicationController
  # Render this layout
  layout 'admin'
  
  def index
    list
    render('list')
  end
  
  
  def list
    @sections = Section.order("sections.position ASC")
  end
  
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new
    @section_count = Section.count + 1
  end
  
  
  def create
    # instantiates new Section object based on form params
    @section = Section.new(params[:section])
    
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to :action => 'list'
    else
      flash[:notice] = "Create failed - you need to enter a name"
      @section_count = Section.count + 1
      render('new')
    end
  end
  
  
  
  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
  end
  
  
  def update
    @section = Section.find(params[:id])     
    
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section update successful."
      redirect_to(:action => 'show', :id => @section.id)
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
    redirect_to :action => 'list'    
  end
  
  
  
  
  
end
