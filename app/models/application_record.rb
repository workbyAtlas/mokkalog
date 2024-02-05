class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  #Shortern Words
  def short_name(word)
    if word.length > 12
      short = word[0, 10]
      short + "..."
    else
      word
    end
  end
  def one_liner(word)
    if word.length > 20
      short = word[0,15]
      short + "..."
    else
      word
    end
  end

  def shorter_name(word,a,b)
    if word.length > a
      short = word[0, b]
      short + "..."
    else
      word
    end
  end

  #Image Handler
  def image_handler(image,size)
    if size == "small"
      image.variant(resize_to_fill: [100,100]).processed
    elsif size == "normal"
      image.variant(resize_to_fill: [200,200]).processed
    elsif size == "big"
      image.variant(resize_to_fit: [400,500]).processed
    elsif size == "brand"
      image.variant(resize_to_fill: [300,300]).processed
    elsif size == "quick"
      image.variant(resize_to_fit: [400,600]).processed
    elsif size == "gallery"
      image.variant(resize_to_fit: [400,400]).processed
    elsif size == "fourfour"
      image.variant(resize_to_fit: [400,400]).processed
    elsif size == "small_brand_image"
      image.variant(resize_to_fill:[60,60]).processed
    end
    
    #image.variant(resize_to_fill: [350,400]).processed if size == "post"
  end

  #Check for Inapporpirate Words
  def validate_bad_words(attribute_name)
    keywords = ['faggot', 'nigger', 'retarded', 'chink','heil hitler']
    errors.add(attribute_name, "cannot contain the words") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.match?(/\b#{Regexp.escape(keyword)}\b/i) }
  end
  def validate_bad_names(attribute_name)
    keywords = ['ass', 'cunt','cock','fag']
    errors.add(attribute_name, "contains an inappropriate word") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.include?(keyword) }
  end
end
