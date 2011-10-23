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
    @pages = Page.sorted.where(:subject_id => @subject.id)
  end  
  
  def show
    @page = Page.find(params[:id])
  end  
  
  def new
    @page = Page.new(:subject_id => @subject.id)
    @page_count = @subject.pages.size + 1
    @subjects = Subject.order('position ASC')
  end
    
  def create
    new_position = params[:page].delete(:position)
    # Instantiate page object based on params
    @page = Page.new(params[:page])
    
    if @page.save
      @page.move_to_position(new_position)
      # if saved correctly
      flash[:notice] = "Page created successfully"
      redirect_to(:action => 'list', :subject_id => @page.subject_id)
    else
      # if error saving
      flash.now[:notice] = "Make sure your page has a name - genius."
      @page_count = @subject.pages.size + 1
      render('new')
    end
        
  end  
  
  def edit
    @page = Page.find(params[:id])  
    @page_count = @subject.pages.size
    @subjects = Subject.order('position ASC')
  end  
  
  def update
    @page = Page.find(params[:id])    
    new_position = params[:page].delete(:position)
    
    if @page.update_attributes(params[:page])
      @page.move_to_position(new_position)
      flash[:notice] = "Page updated successfully"
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
      flash.now[:notice] = "Page could not be updated"
      @page_count = @subject.pages.size
      render('edit')
      
    end
  end  
  
  def delete
    @page = Page.find(params[:id])
    render 'delete'
  end
    
  def destroy
    page = Page.find(params[:id])
    page.move_to_position(nil)
    page.destroy
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
