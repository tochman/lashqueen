class Inflections < ::ActiveSupport::Inflector::Inflections
end


class String
  def swedish_pluralize
    return self if self.blank?
    SwedishPluralize.pluralize(self)
  end

  def clean_string
      self.tr('äåö', 'aao')
  end
end