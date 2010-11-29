require File.dirname(File.expand_path(__FILE__)) + '/../lib/wizard'
require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'

describe Wizard do

  before :all do
    Wizard.prepare :conjure do |c|
      c.name "Turn into a toad"
    end
  end

  it "should prepare a spell" do
    attributes = Wizard.prepare :spell do |s|
      s.name "Small Fireball"
      s.level 1
    end
    attributes.should be_a Array
  end 

  it "should invoke a previously prepared spell" do

    conjure = Wizard.invoke :conjure

    conjure.should_not be_nil
    conjure.should be_a Conjure
    conjure.name.should == "Turn into a toad"
  end

  it "should invoke a prepared spell with custom name" do
    conjure = Wizard.invoke :conjure do |c|
      c.name "Turn back to knight"
    end

    conjure.should_not be_nil
    conjure.should be_a Conjure
    conjure.name.should == "Turn back to knight"
  end

  it "should override attributes with a hash" do
    conjure = Wizard.invoke(:conjure, :name => "Turn into a Camel")
    conjure.should_not be nil
    conjure.name.should == "Turn into a Camel"
  end

  it "should change attributes on the second invoke" do
    conjure = Wizard.invoke(:conjure)
    conjure.should_not be_nil
    conjure.name.should == "Turn into a toad"

    conjure = Wizard.invoke(:conjure, :name => "Turn into a snake")
    conjure.should_not be_nil
    conjure.name.should == "Turn into a snake"
  end

end
