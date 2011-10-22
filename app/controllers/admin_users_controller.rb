class AdminUsersController < ApplicationController
  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @admin_users = AdminUser.sorted
  end
  
  def new
    @admin_user = AdminUser.new
  end
  
  def create
    @admin_user = AdminUser.new(params[:admin_user])
    if @admin_user.save
      flash[:notice] = "New Admin User has been saved"
      redirect_to(:action => 'list')
    else      
      flash[:notice] = "New Admin User could not be saved"
      render('new')
    end
  end
  
  def edit
    @admin_user = AdminUser.find(params[:id])    
  end
  
  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(params[:admin_user])
      flash[:notice] = "Admin User updated successfully"
      redirect_to(:action => 'list')
    else
      flash[:notice] = "There were errors in the update"
      render('edit')     
    end
  end
  
  
  def delete
    @admin_user = AdminUser.find(params[:id])  
  end
  
  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin User destroyed successfully"
    redirect_to(:action => 'list')
  end
  
  
 
  
    
      
  
end
