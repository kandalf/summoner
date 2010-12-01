require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => File.dirname(File.expand_path(__FILE__)) + "/db/summoner.sqlite3"
)

class Monster
  attr_accessor :kind
  attr_accessor :power

  def self.create(*args)
    @object = self.new
    args.first.each do |k, v|
      @object.send("#{k.to_s}=", v)
    end
    @object
  end
  
  def update_attributes (*args)
    args.first.each do |k, v|
      self.send("#{k.to_s}=", v)
    end
    true
  end
  def save(validate=true)
    return true
  end
end

class Esper < Monster
end

module Monsters
  class Avatar < Monster
  end
end

class Power < ActiveRecord::Base;end
class Aeon < ActiveRecord::Base;end
