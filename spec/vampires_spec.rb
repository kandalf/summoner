require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'
require File.dirname(File.expand_path(__FILE__)) + '/../lib/summoner'

class Vampire < Monster
  attr_accessor :name
end

Summoner.prepare :vampire do |m|
  m.name "Dracula"
end

describe Vampire do
  it "should be Vlad" do
    vlad = Summoner.summon :vampire
    vlad.name.should == "Dracula"
  end

  it "should be Edward" do
    edward = Summoner.summon :vampire, :name => "Edward"
    edward.name.should == "Edward"
  end

  it "should be Vlad again" do
    Summoner.summon(:vampire).name.should == "Dracula"
  end
end
