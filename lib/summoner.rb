require 'summoner/beast'
require 'summoner/definition_duplicated_error'
require 'summoner/unprepared_beast_error'
require 'summoner/hash'

module Summoner
  @@beasts = {}

  def self.summon(name, attrs = {})
    raise UnpreparedBeastError unless @@beasts.has_key? name
  
    klass = @@beasts[name].options.has_key?(:class) ? @@beasts[name].options[:class] : eval(name.to_s.capitalize)

    monster = klass.create(@@beasts[name].attributes.merge(attrs.symbolize_keys))

    if block_given?
      bicho = @@beasts[name].dup
      yield bicho
      monster = klass.create(bicho.attributes.merge(attrs.symbolize_keys))
    end

    monster.save(:validate => false)
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
      begin
        object = self.create(options)
        yield object if block_given?
        object.save(false)
        object
      rescue ArgumentError
        puts "You're probably summoning something by itself. Try defining attributes as attr = value"
      end
    end
  end
end

ActiveRecord::Base.extend(Summoner::ClassMethods) if defined? ActiveRecord
