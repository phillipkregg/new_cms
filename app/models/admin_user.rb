require 'digest/sha1'
class AdminUser < ActiveRecord::Base
  has_and_belongs_to_many :pages
  has_many :section_edits 
  has_many :sections, :through => :section_edits
  
  EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  
  #validates_presence_of :first_name
  #validates_length_of :first_name, :maximum => 25
  #validates_presence_of :last_name
  #validates_length_of :last_name, :maximum => 50
  #validates_presence_of :username
  #validates_length_of :username => :within => 8..25  
  #validates_uniqueness_of :username
  #validates_presence_of :email
  #validates_length_of :email, :maximum => 100
  #validates_format_of :email, :with => EMAIL_REGEX
  #validates_confirmation_of :email
  
  # New style of validation
  validates :first_name, :presence => true, :length => {:maximum => 25}
  validates :last_name, :presence => true, :length => {:maximum  => 50}
  validates :username, :length => {:within => 8..25}, :uniqueness  => true
  validates :email, :presence => true, :length => {:maximum => 100}, 
            :format => EMAIL_REGEX, :confirmation => true 
  # Only on Create, so other attributes of this user can be changed
  validates_length_of :password, :within => 8..25, :on => :create
  
  
  before_save :create_hashed_password
  after_save :clear_password
  
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
  
  attr_protected :hashed_password, :salt
  
  
  ##### Authentication #####
  
  def self.authenticate(username="", password="")
    user = AdminUser.find_by_username(username)
    
    if user && user.password_match?(password)
      return user      
    else
      return false
    end   
  end
  
  def password_match?(password="")
    hashed_password == AdminUser.hash_with_salt(password, salt)
  end    
  
  ######  Authentication password hashing ########
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")    
  end  
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")    
  end
    
  ###### Private methods to be used only in the class #######
  private
  
  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password, salt)
    end
  end
   
  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end
  
  

end
