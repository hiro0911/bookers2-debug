class SearchController < ApplicationController
	 before_action :authenticate_user!, except: [:search]

	def search
		@model = params['search']['model']
    	@content = params['search']['content']
    	@condition = params["search"]["how"]
    	@posts = search_for(@model, @content, @how)
    	
	end

	private

		def match(model, content)
			if model == 'user'
				User.where(name: content)
			else model == 'book'
				Book.where(title: content) #,body: content
			end
		end

		def forward(model, content)
			if model == 'user'
				User.where("name like ?", "#{content}%")
			else model == 'book'
				Book.where("title like?", "#{content}%") #, ("body like?", "#{content}%")
			end
		end

		def backward(model, content)
			if model == 'user'
				User.where("name like ?", "%#{content}")
			else model == 'book'
				Book.where("title like ?", "%#{content}")
			end
		end

		def partical(model, content)
			if model == 'user'
				User.where("name like ?", "%#{content}%").page(params[:page]).per(10)
			else model == 'book'
				Book.where("title like ?", "%#{content}%").page(params[:page]).per(10)
			end
		end

	    def search_for(model, content, how)
	        case @condition
	        when 'match'
	        	match(model, content)
	        when 'forward'
	        	forward(model, content)
	        when 'backward'
	        	backward(model, content)
	        when 'partical'
	        	partical(model, content)
	        end
	    end
end