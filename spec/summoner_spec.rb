require File.dirname(File.expand_path(__FILE__)) + '/spec_helper'
require File.dirname(File.expand_path(__FILE__)) + '/../lib/summoner'

describe Summoner do 

  before :each do 
    Summoner.prepare :monster do |m|
      m.kind "Guardian"
      m.power 5
    end
  end

  after :each do
    Summoner.reset
  end

  it "should prepare a monster" do
    beast = Summoner.prepare :esper do |s|
      s.power 6
    end 
    beast.should be_a Summoner::Beast
  end  

  it "should summon a previously prepared monster" do

    monster = Summoner.summon :monster

    monster.should_not be_nil
    monster.should be_a Monster
    monster.kind.should == "Guardian"
  end

  it "should summon a prepared monster with custom kind" do
    monster = Summoner.summon :monster do |m|
      m.kind "Esper"
      m.power 10
    end

    monster.should_not be_nil
    monster.should be_a Monster
    monster.kind.should == "Esper"
    monster.power.should == 10
  end

  it "should override attributes with a hash" do
    monster = Summoner.summon(:monster, :kind => "Avatar")
    monster.should_not be nil
    monster.kind.should == "Avatar"
  end

  it "should change attributes on the second summon" do
    monster = Summoner.summon(:monster)
    monster.should_not be_nil
    monster.kind.should == "Guardian"

    monster = Summoner.summon(:monster, :kind => "Aeon")
    monster.should_not be_nil
    monster.kind.should == "Aeon"
  end

  it "should pepare a monster with a custom class" do
    beast = Summoner.prepare :avatar, :class => Monster do |a|
      a.kind "Avatar"
    end

    beast.should be_a Summoner::Beast

    avatar = Summoner.summon(:avatar)

    avatar.should be_a Monster
    avatar.kind.should == "Avatar"
  end

  it "should prepare a monster with a custom namespaced class" do
    beast = Summoner.prepare :avatar, :class => Monsters::Avatar do |a|
      a.kind "Monster avatar"
    end

    beast.should be_a Summoner::Beast

    avatar = Summoner.summon(:avatar)
    avatar.should be_a Monsters::Avatar
    avatar.kind.should == "Monster avatar"
  end

  it "should add summon ability to AR" do
    creature = Aeon.summon do |a|
      a.name = "Flux"
      a.power = 10 
    end

    creature.should_not be_nil
    creature.should be_a Aeon
    creature.name.should == "Flux"
    creature.power.should == 10
  end

end
