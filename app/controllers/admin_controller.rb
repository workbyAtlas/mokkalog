class AdminController < ApplicationController

	before_action :mod?


	def index
		@activities = Activity.all
		@q = @activities.ransack(params[:q])
		@activities_ordered = @q.result(distinct: true).includes(:post, :user).order(created_at: :desc)
		@activities_ordered = Kaminari.paginate_array(@activities_ordered).page(params[:page]).per(100)

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

  def mokkalab
  	
    begin
      response = OpenAI::Client.new.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [
            { role: "system", content: "Your name is Molla a helpful and stylish assistant that helps user recommend type of clothing based on the event. You recommend color and type of clothing to wear. You recommend one top, one bottom, and one accessories." },
            { role: "user", content: "Hey I am going on a boat party. What should I wear?" }
          ]
        }
      )
      @poem = response["choices"].first["message"]["content"]

    rescue OpenAI::Error => e
      @error = "An error occurred: #{e.message}"
    end
end
