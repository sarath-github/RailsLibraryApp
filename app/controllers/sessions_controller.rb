class SessionsController < ApplicationController
	def create
		user = User.find_by_name(params[:session][:name].downcase)
    	if user && user.authenticate(params[:session][:password])
      		redirect_to user
    	else
      		flash[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
    	end
	end
	def new
		
	end
	def destroy
		
	end
end
