class SearchController < ApplicationController
	
	def search
		@posts = Post.all
    	redirect_to adroom_path
	end
end

