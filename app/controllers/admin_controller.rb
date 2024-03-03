class AdminController < ApplicationController
	before_action :mod?


	def index
		@activities = Activity.all
	end
	def data
		@posts = Post.all
		@brands = Brand.all

		@q = @posts.select('posts.*, COUNT(activities.id) AS activities_count')
                       .left_joins(:activities)
                       .group('posts.id')
                       .ransack(params[:q])

      	@posts = @q.result(distinct: true).order(activities_count: :desc)
      	@posts = Kaminari.paginate_array(@posts).page(params[:page]).per(20)
	end

	def brand_data
		@brands = Brand.all
		@q = @brands.ransack(params[:q])
		@brands = @q.result(distinct: true).order(views: :desc)

		@brands.each do |brand|
		  total_activities_count = 0

		  # Iterate through each post of the brand
		  brand.posts.each do |post|
		    # Sum up the count of activities for each post
		    total_activities_count += post.activities.count
		  end

		  # Assign the total_activities_count to the brand object
		  brand.total_activities_count = total_activities_count
		end


		@brands = Kaminari.paginate_array(@brands).page(params[:page]).per(20)
	end
end
