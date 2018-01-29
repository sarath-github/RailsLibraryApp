class BooksController < ApplicationController
  before_filter :load_book, :only => [:show, :edit, :update, :destroy]
	def index

		@books = Book.all
    
    print params['sort']
		if !params['sort'].blank?
		  @books = Book.sort(params['sort'], 'ASC')	
    elsif !session[:current_session_sort_info].blank?
      @books = Book.sort(session[:current_session_sort_info], 'ASC')
      print "Sort info: ",session[:current_session_sort_info]
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
        
    if !params['sort'].blank?
      session[:current_session_sort_info] = params['sort'] 
    end
  end

    def show

    	respond_to do |format|
      		format.html # show.html.erb
      		format.json { render json: @book }
    	end
  	end

	def new
    @book = Book.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
  end

  # book /books
  # book /books.json
  def create
    @book = Book.new(params[:book])
    respond_to do |format|
      if @book.save
        
        format.html { redirect_to @book, notice: 'book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update

    respond_to do |format|
      if @book.update_attributes(params[:book])

        format.html { redirect_to @book, notice: 'book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def checkout
    @books = Book.where("available_copies > ?", 0)
    @users = User.all
  end

  def docheckout
    print params[:tag_ids]
    @selectedbooks = params[:tag_ids]
    @user = User.find(params[:user_id].to_i)
    @selectedbooks.each do |selectedbook|
      @book = Book.find(selectedbook.to_i)
      @book.available_copies = @book.available_copies - 1
      @book.save
      @booktaken = BooksTaken.new
      @booktaken.user_id = @user.id
      @booktaken.book_id = @book.id
      @booktaken.check_out_time = Time.now
      @booktaken.save
      @activity = UserActivitie.new
      @activity.user_id = @user.id
      @activity.description = "Taken Book #{@book.name} at #{@booktaken.check_out_time}"
      @activity.save
      print @book.available_copies
    end
    respond_to do |format|
      if true
        format.html { redirect_to books_url, notice: 'book was successfully updated.' }
        format.json { head :no_content }
      end
    end
  end

  def checkin
    @books = Book.all
    @users = User.all
  end

  def docheckin
    @selectedbooks = params[:tag_ids]
    @user = User.find(params[:user_id].to_i)
    @selectedbooks.each do |selectedbook|
      @book = Book.find(selectedbook.to_i)
      @book.available_copies = @book.available_copies + 1
      @book.save
      @booktaken = BooksTaken.new
      @booktaken.user_id = @user.id
      @booktaken.book_id = @book.id
      @booktaken.check_in_time = Time.now
      @booktaken.save
      @activity = UserActivitie.new
      @activity.user_id = @user.id
      @activity.description = "Returened Book #{@book.name} at #{@booktaken.check_in_time}"
      @activity.save
    end
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'book was checked in successfully.'}
      format.json {head :no_content}
    end
  end

  def search
  end

  def load_book
    @book = Book.find(params[:id])
  end

  def bookstouser
    @book = Book.all
  end
end

