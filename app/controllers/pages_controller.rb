class PagesController < ApplicationController
  # Render this layout
  layout 'admin'
  
  def index
    list
    render('list')
  end
    
  def list
    @pages = Page.order("pages.position ASC")
  end  
  
  def show
    @page = Page.find(params[:id])
  end  
  
  def new
    @page = Page.new
    @page_count = Page.count + 1
  end
    
  def create
    # Instantiate page object based on params
    @page = Page.new(params[:page])
    
    if @page.save
      # if saved correctly
      flash[:notice] = "Page created successfully"
      redirect_to(:action => 'list')
    else
      # if error saving
      flash.now[:notice] = "Make sure your page has a name - genius."
      @page_count = Page.count + 1
      render('new')
    end
        
  end  
  
  def edit
    @page = Page.find(params[:id])  
    @page_count = Page.count
  end  
  
  def update
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page])
      flash[:notice] = "Page updated successfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      flash.now[:notice] = "Page could not be updated"
      @page_count = Page.count
      render('edit')
      
    end
  end  
  
  def delete
    @page = Page.find(params[:id])
  end
    
  def destroy
    Page.find(params[:id]).destroy
    flash[:notice] = "Page successfully destroyed"
    redirect_to(:action => 'list')
  end
    
end
