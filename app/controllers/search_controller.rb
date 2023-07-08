class SearchController < ApplicationController
	
	def search
		posts = if params[:search]
			posts_with_tag_search
		else
			Post.all
		end
		@posts = posts
		render turbo_stream: turbo_stream.replace("posts_list", 
			partial: "posts/list", 
			locals: {posts: @posts})
	end

	def advsearch
		@posts =Post.all
	end

	private

def posts_with_tag_search
    parsed_tags.reduce(Post.includes(:user).all) do |posts, tag|
      case tag[:field]
      # this is for association(user)
      when "user"
        case tag[:operator]
        when "equals"
          posts.joins(:user).where("users.name = ?", tag[:value])
        when "contains"
          posts.joins(:user).where("users.name LIKE ?", "%#{tag[:value]}%")
        when "except"
          posts.joins(:user).where.not("users.name LIKE ?", "%#{tag[:value]}%")
        else
          posts
        end
      else
        case tag[:operator]
        when "equals"
          #Danger to SQL injection here?
          posts.where("#{tag[:field]} = ?", tag[:value])
		when "except"
          #SQL inject protection
          field = case tag[:field]
                  when "title"
                    "posts.title"
                  when "color"
                    "posts.color"
                  when "material"
                  	"posts.material"
                  when "category"
                  	"posts.category"
                  when "sub_category"
                  	"posts.sub_category"
                  when "c_type"
                  	"posts.c_type"                  	                  	
                  else
                    "posts.title"
                  end

          posts.where.not("#{field} LIKE ?", "%#{tag[:value]}%")


        when "contains"
          #SQL inject protection
          field = case tag[:field]
                  when "title"
                    "posts.title"
                  when "color"
                    "posts.color"
                  when "material"
                  	"posts.material"
                  when "category"
                  	"posts.category"
                  when "sub_category"
                  	"posts.sub_category"
            
                  else
                    "posts.title"
                  end

          posts.where("#{field} LIKE ?", "%#{tag[:value]}%")
        else
          posts
        end
      end
    end
  end

	def parsed_tags
		params[:search].map do |tag|
			field, operator, value = tag.split("__|__")
			{field: field, operator: operator, value: value}
		end
	end

end

