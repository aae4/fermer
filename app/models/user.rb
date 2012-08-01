require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible :hashed_password, :name, :salt, :password, :password_confirmation, :role, :email
  validates :name, :length => {:minimum => 3, :maximum => 20}
  validates_presence_of :name, :password, :email
  validates_uniqueness_of :name
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => {:with => email_regex},
				:uniqueness => { :case_sensitive => false }



  def self.authenticate(name,password)
	user=self.find_by_name(name)
	if user
		expected_password=encrypted_password(password,user.salt)
		if user.hashed_password != expected_password
			user=nil
		end
	end
	user
  end

  def password
	@password
  end

  def password=(pwd)
	@password=pwd
	return if pwd.blank?
	create_new_salt
	self.hashed_password=User.encrypted_password(self.password,self.salt)
  end

private
  def password_non_blank
	errors.add(:password, "Password can't be blank") if hashed_password.blank?
  end

  def create_new_salt
	self.salt=self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password,salt)
	string_to_hash = password+"wibble"+salt
	Digest::SHA1.hexdigest(string_to_hash)
  end


end
