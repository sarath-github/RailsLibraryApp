class UsersController < ApplicationController
	def new
    print params
		@user = User.new
	end

	def create
	  @user = User.new(params[:user])
      respond_to do |format|
   		if @user.save 
       		format.html { redirect_to @user, notice: 'User was successfully created.' }
       		format.json { render json: @user, status: :created, location: @user }
      else
        	format.html { render action: "new" }
        	format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

  def show
    print params
    @user = User.find(params[:id])
    if @user.isadminuser
      redirect_to books_path
    else
      @books = Book.all
    end
  end

  def history
    @user_id = params[:user_id].to_i
    @history = UserActivitie.where("user_id = ?", @user_id)
  end
end
