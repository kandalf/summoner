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
end
