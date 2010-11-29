require 'wizard/attributes'

module Wizard
  class DefinitionDuplicatedError < RuntimeError
  end

  class UnpreparedSpellError < RuntimeError
  end

  @@attributes = Attributes.new
  @@spells = {}

  def self.attributes
    @@attributes
  end

  def self.invoke(name, attrs = {})
    raise UnpreparedSpellError unless self.attributes.has_key? name

    if @@spells.has_key? :name
      spell = @spells[:name]
    else
      new_attrs = self.attributes[name].clone.merge(attrs)
      prepared_options = new_attrs.delete(:options)

      klass = prepared_options.has_key?(:class) ? prepared_options[:class] : eval(name.to_s.capitalize)#.constantize
  
      spell = klass.create(new_attrs)
    end
    if block_given?
      yield new_attrs
      spell.update_attributes(new_attrs)
    end
    self.attributes[name].merge(new_attrs)
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
