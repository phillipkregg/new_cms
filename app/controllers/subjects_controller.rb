class SubjectsController < ApplicationController
  
  # Render this layout
  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  
  def new
    @subject = Subject.new
    @subject_count = Subject.count + 1
  end
  
  
  def create
    # create an instance of a new object using paramaters coming from the form
    @subject = Subject.new(params[:subject])
    
    # save the object
    if @subject.save
      # if the save succeeds
      flash[:notice] = "Subject created successfully."
      redirect_to :action => 'list'
    else
      # if save fails, redisplay the form
      flash.now[:notice] = "Please add a name."
      @subject_count = Subject.count + 1
      render('new')
    end
  end
  
  
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  
  def update
    # Find an instance of a new object using paramaters coming from the form
    @subject = Subject.find(params[:id])
        
    # Update the object
    if @subject.update_attributes(params[:subject])
      # if the update succeeds
      flash[:notice] = "Subject updated successfully."
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # if save fails, redisplay the form
      flash[:notice] = "Please add a Name"
      @subject_count = Subject.count
      render('edit')
    end
  end
  
  
  def delete
    @subject = Subject.find(params[:id])
  end
  
  
  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject destroyed successfully."
    redirect_to(:action => 'list')
  end
  
  
  
end
