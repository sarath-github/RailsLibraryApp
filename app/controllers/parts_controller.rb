class PartsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@part = @book.parts.create(params[:part])
		redirect_to book_path(@book)
    end
    def destroy
    	@book = Book.find(params[:book_id])
    	@part = @book.parts.find(params[:id])
    	@part.destroy
    	redirect_to book_path(@book)
  end
end
