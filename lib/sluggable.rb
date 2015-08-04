module Sluggable
  extend ActiveSupport::Concern

  included do # this is for class methods
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym)) # to_slug(self.title) etc
    existing_entry = self.class.find_by slug: the_slug
    count = 2
    while existing_entry && existing_entry != self
      the_slug = append_suffix(the_slug, count)
      existing_entry = self.class.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split('').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + '-' + count.to_s
    end
  end

  def to_slug(name)
    str = name.downcase.strip
    str.gsub!(' ', '-')
    str.gsub!(/[^\w-]/, '') # removes all symbols except -
    str
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end
