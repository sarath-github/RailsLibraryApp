class PublishersController < ApplicationController
	def create
		@publisher = Publisher.new(params[:publisher])
		respond_to do |format|
		  if @publisher.save
		    format.html { redirect_to @publisher, notice: 'publisher was successfully created.' }
        format.json { render json: @publisher, status: :created, location: @publisher }
      else
        format.html { render action: "new" }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
	end

	def index
		@publishers = Publisher.all
		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @publishers }
      	end
	end

	def edit
	 	@publisher = Publisher.find(params[:id])
	 end 

	 def show
	 	@publisher = Publisher.find(params[:id])
	 	respond_to do |format|
	 		format.html # show.html.erb
	 		format.json { render json: @publisher}
	 	end
	 end
	 def update
	 	@publisher = Publisher.find(params[:id])

    	respond_to do |format|
      	if @publisher.update_attributes(params[:publisher])

        	format.html { redirect_to @publisher, notice: 'publisher was successfully updated.' }
        	format.json { head :no_content }
      	else
        	format.html { render action: "edit" }
        	format.json { render json: @publisher.errors, status: :unprocessable_entity }
      	end
      end
	 	
	 end
	 def destroy
    	@publisher = Publisher.find(params[:id])
    	@publisher.destroy

    	respond_to do |format|
      		format.html { redirect_to publishers_url}
      		format.json { head :no_content }
      	end
    end
    def new
    	@publisher = Publisher.new
    	respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @publisher }
    	end
    end
end
