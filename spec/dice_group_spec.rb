require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/dice_group'

describe DiceGroup do
  describe "basic dice group functionality" do
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
  
    # This one seems like it may not be strictly necessary
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
    
    it "should not consider a straight a bust" do
      DiceGroup.new([1,2,3,4,5,6]).should_not be_bust
    end
  end
  
  describe "filling" do
    it "should recognize a fill correctly" do
      DiceGroup.new([1,1,1,5,5,5]).should be_fill
      DiceGroup.new([1,2,2,2,5,5]).should be_fill
      DiceGroup.new([5,5,5,5,5,5]).should be_fill
      DiceGroup.new([2,2,2,2,2,2]).should be_fill
      DiceGroup.new([2,2,2]).should be_fill
      DiceGroup.new([1]).should be_fill
      DiceGroup.new([5,5]).should be_fill
      
      # straight
      DiceGroup.new([5,2,3,6,1,4]).should be_fill
      
      DiceGroup.new([2,2,3]).should_not be_fill
      DiceGroup.new([1,4]).should_not be_fill
      DiceGroup.new([2,5,5]).should_not be_fill
      
    end
  end

  describe "scoring" do
    it "should know the correct value of 1s and 5s" do
      DiceGroup.new([1,1]).score.should == 200
      DiceGroup.new([5]).score.should == 50
    end
    
    it "should know the correct value of a triplet" do
      DiceGroup.new([2,2,2]).score.should == 200
      DiceGroup.new([1,1,1,]).score.should == 1000
    end
    
    it "should know when the dice don't score anything" do
      DiceGroup.new([2,3,4]).score.should == 0
    end
    
    it "should know the score of a straigh" do
      DiceGroup.new([6,5,4,3,2,1]).score.should == 1500
    end
    
    it "should choose triplet values instead of individual values for 1s and 5s" do
      DiceGroup.new([1,1,1,1]).score.should == 1100
      DiceGroup.new([5,5,5,5]).score.should == 550
      DiceGroup.new([1,1,1,1,1,1]).score.should == 2000
      DiceGroup.new([5,5,5,5,5,5]).score.should == 1000
    end
  end
  
  describe "#scoring_options" do
    it "should present an array of possible moves" do
      DiceGroup.new([1,2,3]).scoring_options.should == [[Die.new(1)]]
      DiceGroup.new([1,2,3,4,5]).scoring_options.should == 
        [[Die.new(1)],
         [Die.new(5)]]
      DiceGroup.new([1,2,3,4,5,6]).scoring_options.should == 
        [
         [Die.new(1),Die.new(2),Die.new(3),Die.new(4),Die.new(5),Die.new(6)],
         [Die.new(1)],
         [Die.new(5)],
        ]
      DiceGroup.new([1,1,1]).scoring_options.should ==
        [
          [Die.new(1),Die.new(1),Die.new(1)],
          [Die.new(1)],
          [Die.new(1)],
          [Die.new(1)]
        ]
    end
  end
end