class User < ActiveRecord::Base
  attr_accessible :name, :password, :isadmin

  before_save { |user| user.name = name.downcase }
  def authenticate(password)
  	if self.password == password
  		true
  	else
  		false
  	end
  end

  def isadminuser()
  	if self.isadmin
  		true
  	else
  		false
  	end
  end
end
