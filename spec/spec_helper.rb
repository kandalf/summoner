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

class Esper < Monster
end
