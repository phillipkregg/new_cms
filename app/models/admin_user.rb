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
  validates :username, :length => {:within 8..25}, :uniqueness  => true
  validates :email, :presence => true, :length => {:maximum => 100}, 
            :format => EMAIL_REGEX, :confirmation => true 
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
  
  def self.hash(password="")
    Digest::SHA1.hexdigest(password)    
  end
  
    
    

end
