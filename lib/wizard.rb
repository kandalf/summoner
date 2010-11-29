require 'wizard/attributes'

module Wizard
  class DefinitionDuplicatedError < RuntimeError
  end

  @@attributes = Attributes.new
  @@spells = {}

  def self.attributes
    @@attributes
  end

  def self.invoke(name, attributes = {})
    if @@spells.has_key? :name
      spell = @spells[:name]
    else
      new_attributes = self.attributes[name].clone.merge(attributes)
      prepared_options = new_attributes.delete(:options)

      klass = prepared_options.has_key?(:class) ? prepared_options[:class] : eval(name.to_s.capitalize)#.constantize
  
      spell = klass.create(new_attributes)
    end
    if block_given?
      yield new_attributes
      spell.update_attributes(new_attributes)
    end
    self.attributes[name].merge(new_attributes)
    @@spells[name] = spell
  end

  def self.prepare(name, options = {}, &block)
    key = name.to_sym
    raise DefinitionDuplicatedError if self.attributes.has_key? key
    self.attributes[key] = Attributes.new
    self.attributes[key][:options] = options
    yield self.attributes[key]
  end

end
