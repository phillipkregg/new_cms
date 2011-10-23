class PagesController < ApplicationController
  # Render this layout
  layout 'admin'
  
  before_filter :confirm_logged_in
  before_filter :find_subject
  
  def index
    list
    render('list')
  end
    
  def list
    @pages = Page.order("pages.position ASC").where(:subject_id => @subject.id)
  end  
  
  def show
    @page = Page.find(params[:id])
  end  
  
  def new
    @page = Page.new(:subject_id => @subject.id)
    @page_count = Page.count + 1
    @subjects = Subject.order('position ASC')
  end
    
  def create
    # Instantiate page object based on params
    @page = Page.new(params[:page])
    
    if @page.save
      # if saved correctly
      flash[:notice] = "Page created successfully"
      redirect_to(:action => 'list', :subject_id => @page.subject_id)
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
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
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
    redirect_to(:action => 'list', :subject_id => @subject.id)
  end
  
  
  private
  
  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])    
    end
  end
  
  
  
  
    
end
