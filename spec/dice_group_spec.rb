require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/dice_group'

describe DiceGroup do
  describe "basic dice functionality" do
    it "should have the right number of dice" do
      DiceGroup.new.dice.size.should == 6
    end
  
    it "should take a specific set of dice" do
      dice = [Die.new, Die.new, Die.new]
      dg = DiceGroup.new(dice)
      dg.dice.should == dice
    end
  
    it "should take an array of numbers as dice" do
      dice = [2,3,4]
      dg = DiceGroup.new(dice)
      dg.dice.should == [Die.new(2), Die.new(3), Die.new(4)]
    end
  
    it "should accept an array of numbers and dice" do
      dice = [4, Die.new(3), 2]
      dg = DiceGroup.new(dice)
      dg.dice.should == [Die.new(4), Die.new(3), Die.new(2)]
    end
  end

  describe "busting" do
    it "should recognize a bust correctly" do
      DiceGroup.new([2,3,4,6]).should be_bust
    end
    
    it "should not consider a group a bust if it has a 1 or 5" do
      DiceGroup.new([1,2,3]).should_not be_bust
      DiceGroup.new([2,3,5]).should_not be_bust
    end
    
    it "should not consider a triplet a bust" do
      DiceGroup.new([2,2,2,]).should_not be_bust
    end
  end

  describe "scoring" do
    it "should recognize 1s as scoring dice" do
      DiceGroup.new([1]).scoring_dice.should == [Die.new(1)]
    end
    
    it "should recognize 5s as scoring dice" do
      DiceGroup.new([5]).scoring_dice.should == [Die.new(5)]
    end
    
    it "should recognize 1s and 5s when mixed with other dice" do
      DiceGroup.new([1,2,3,4,5]).scoring_dice.should == [Die.new(1), Die.new(5)]
    end
    
    it "should recognize triplets as scoring dice" do
      DiceGroup.new([2,2,2]).scoring_dice.should == [Die.new(2), Die.new(2), Die.new(2)]
    end
    
    xit "should know the correct value of 1s and 5s" do
      DiceGroup.new([1]).score.should == 100
    end
  end
  
end