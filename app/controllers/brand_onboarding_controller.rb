class BrandOnboardingController < ApplicationController
	include Wicked::Wizard
	steps :image, :style, :desc, :origin, :state, :links, :banner, :collab, :gallery,:confirmed, :finale

	def show
		@brand = Brand.find(session[:brand_id])
		render_wizard
	end

	def update
		@brand = Brand.find(session[:brand_id])
		
		case step
		when :image, :origin,:state, :links, :banner, :gallery, :desc, :collab
			@brand.update(brand_params)
			render_wizard @brand
		when :style
			#render_wizard @brand if @brand.valid?(:style_validator)
			
			if params[:brand] && !params[:brand][:styles].empty?
				delete_styles(@brand, params[:brand][:styles],)
			end
			@brand.update(brand_params)
			render_wizard @brand
		end
	end


	private

		def delete_styles(brand, styles)
      brand.styleables.destroy_all
      if not styles.nil?
      #styles = styles.strip.split(',')
        styles.each do |style|
          brand.styles << Style.find_or_create_by(name: style)
        end
      end
    end

    def brand_params
      params.require(:brand).permit(:name, :image, :user_id, :body, :views, :link, :banner,
       :brand_color, :brand_text, :header, :last_edited, :ig_link, :gallery1,:gallery2,:gallery3,
       :styles, :verification, :location, :x_twitter, :badge, :state)
    end
end
