class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def validate_bad_words(attribute_name)
    keywords = ['tiger', 'rabbit']
    errors.add(attribute_name, "cannot contain the words") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.match?(/\b#{Regexp.escape(keyword)}\b/i) }
  end

  def validate_bad_names(attribute_name)
    keywords = ['ass', 'cunt','cock','fag']
    errors.add(attribute_name, "contains an inappropriate word") if self[attribute_name].present? && keywords.any? { |keyword| self[attribute_name].downcase.include?(keyword) }
  end


end
