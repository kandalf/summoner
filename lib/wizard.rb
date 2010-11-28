module Wizard
  class Attributes < Hash
    def method_missing(name, *args, &block)
      if name == :has_one
        self[args.first] = Wizard.invoke args.first
      elsif name == :has_many
        self[args.first] = [Wizard.invoke(args.first)]
      else
        self[name.to_sym] = args
      end
    end
  end

  @@attributes = Attributes.new
  @@spells = {}

  def self.attributes
    @@attributes
  end

  class DefinitionDuplicatedError < RuntimeError
  end

  def self.invoke(name)
    if @@spells.has_key? :name
      spell = @spells[:name]
    else
      attributes = self.attributes[name].clone
      prepared_options = attributes.delete(:options)

      klass = prepared_options.has_key?(:class) ? prepared_options[:class] : eval(name.to_s.capitalize)#.constantize
  
      spell = klass.create(self.attributes[name])
    end
    if block_given?
      yield attributes
      spell.update_attributes(attributes)
    end
    self.attributes[name].merge(attributes)
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

