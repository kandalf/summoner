
class Conjure
  attr_accessor :name  
  attr_accessor :ingredients

  def self.create(*args)
    @object = self.new
    @object.name = args.first[:name].first if args.first.has_key? :name
    @object.ingredients = args.first[:ingredients].first if args.first.has_key? :ingredients
    @object
  end
  
  def update_attributes(*args)
    self.name = args.first[:name].first if args.first.has_key? :name
    self.ingredients = args.first[:ingredients].first if args.first.has_key? :ingredients
  end

end

class Spell
  attr_accessor :name
  attr_accessor :level
end

def mock(name = nil, stubs_and_options = {})
  RSpec::Mocks::Mock.new(name, stubs_and_options)
end
