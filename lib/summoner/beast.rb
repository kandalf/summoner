module Summoner
  class Beast
    attr_accessor :attributes
    attr_accessor :options
    
    def initialize(options = {}, attributes = {})
      self.options    = options
      self.attributes = attributes
    end

    def method_missing(name, *args, &block)
      if name == :has_one
        self.attributes[args.first]   = Summoner.invoke args.first
      elsif name == :has_many
        self.attributes[args.first]   = [Summoner.invoke(args.first)]
      else
        self.attributes[name.to_sym]  = args.first
      end
      self
    end
  end
end
