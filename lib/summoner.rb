require 'summoner/beast'
require 'summoner/definition_duplicated_error'
require 'summoner/unprepared_beast_error'
require 'summoner/hash'

module Summoner
  @@beasts = {}

  def self.summon(name, attrs = {})
    raise UnpreparedBeastError unless @@beasts.has_key? name
  
    @@beasts[name].attributes = @@beasts[name].attributes.merge(attrs.symbolize_keys)

    klass = @@beasts[name].options.has_key?(:class) ? @@beasts[name].options[:class] : eval(name.to_s.capitalize)

    monster = klass.create(@@beasts[name].attributes)

    if block_given?
      yield @@beasts[name]
    end
    monster.update_attributes(@@beasts[name].attributes)
    monster.save(false)
    monster.reload
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


  module ClassMethods
    def summon(options = {}, &block)
      object = self.create
      yield object if block_given?
      object.save(false)
      object
    end
  end
end

ActiveRecord::Base.extend(Summoner::ClassMethods) if defined? ActiveRecord
