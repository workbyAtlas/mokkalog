class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def validate_bad_words(attribute_name)
    keywords = ['faggot', 'nigger', 'retarded', 'chink','heil hitler']
    errors.add(attribute_name, "cannot contain the words") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.match?(/\b#{Regexp.escape(keyword)}\b/i) }
  end

  def validate_bad_names(attribute_name)
    keywords = ['ass', 'cunt','cock','fag']
    errors.add(attribute_name, "contains an inappropriate word") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.include?(keyword) }
  end


  def img_sq_small(image)
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [100,100]).processed
  end

  def img_sq_normal(image)
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [200,200]).processed
    
  end

  def img_sq_big(image)
    return unless image.content_type.in?(%w[image/jpeg image/png image/webp])
    image.variant(resize_to_fill: [400,400]).processed
  end


  def image_handler(image,size)
    if size == "small"
      image.variant(resize_to_fill: [100,100]).processed
    elsif size == "normal"
      image.variant(resize_to_fill: [200,200]).processed
    elsif size == "big"
      image.variant(resize_to_fit: [400,500]).processed
    elsif size == "quick"
      image.variant(resize_to_fit: [400,600]).processed
    end
      

  end
end
