require 'summoner/beast'
require 'summoner/definition_duplicated_error'
require 'summoner/unprepared_beast_error'

module Summoner
  @@beasts = {}

  def self.summon(name, attrs = {})
    raise UnpreparedBeastError unless @@beasts.has_key? name
  
    @@beasts[name].attributes = @@beasts[name].attributes.merge(attrs)

    klass = @@beasts[name].options.has_key?(:class) ? @@beasts[name].options[:class] : eval(name.to_s.capitalize)

    monster = klass.create(@@beasts[name].attributes)

    if block_given?
      yield @@beasts[name]
    end
    monster.update_attributes(@@beasts[name].attributes)
    monster
  end

  def self.prepare(name, options = {}, &block)
    key = name.to_sym
    raise DefinitionDuplicatedError if @@beasts.has_key? key
    @@beasts[key] = Beast.new(options)
    yield @@beasts[key]
  end

  def self.reset
    @@beasts.clear
  end

end
