require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'
require File.dirname(File.expand_path(__FILE__)) + '/../lib/summoner'

class Vampire < Monster
  attr_accessor :name
end


describe Vampire do
  before :all do
    Summoner.prepare :vampire do |m|
      m.name "Dracula"
    end
  end

  it "should override attributes only once" do
    edward = Summoner.summon :vampire, :name => "Edward"
    edward.name.should == "Edward"
    vlad = Summoner.summon :vampire
    vlad.name.should == "Dracula"
  end

  it "should override attributes only once when a block is given" do
    edward = Summoner.summon :vampire do |v|
      v.name "Edward"
    end
    edward.name.should == "Edward"
    vlad = Summoner.summon :vampire
    vlad.name.should == "Dracula"
  end
end
