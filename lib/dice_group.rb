require File.dirname(__FILE__) + '/die'
require File.dirname(__FILE__) + '/array_extensions'
require 'rubygems'

class DiceGroup
  DEFAULT_DICE_NUMBER = 6
  STRAIGHT_VALUE = 1500
  ONES_MULTIPLIER = 1000
  DEFAULT_MULTIPLIER = 100
  ONE_VALUE = 100
  FIVE_VALUE = 50
  
  attr_accessor :dice
  
  def initialize(dice=nil)
    @dice = []
    
    case dice
    when nil
      DEFAULT_DICE_NUMBER.times do
        @dice << Die.new
      end
    when Array
      dice.each do |die|
        case die
        when Die
          @dice << die
        when Fixnum
          @dice << Die.new(die)
        end
      end
    else
      raise InvalidArgumentError, "DiceGroup takes an array of fixnum or dice"
    end
  end
  
  def to_s
    "DiceGroup (#{@dice.collect{|d| d.value}.join(',')})"
  end
  
  def ==(other)
    @dice.sort == other.dice.sort
  end

  def bust?
    score == 0
  end
  
  def fill?
    scoring_dice_count >= @dice.size
  end
  
  # Returns the maximum possible score for this dicegroup
  def score
    score = 0
    
    dice_copy = @dice.dup
    
    return STRAIGHT_VALUE if straight?
    
    triplets.each do |triplet|
      multiplier = triplet == 1 ? ONES_MULTIPLIER : DEFAULT_MULTIPLIER
      score += triplet * multiplier
      3.times {dice_copy.delete_once(triplet)}
    end
    
    # Add 1s and 5s
    score += dice_copy.inject(0) do |sum, d|
      sum += d.value == 1 ? ONE_VALUE : 0
      sum += d.value == 5 ? FIVE_VALUE : 0
    end
  end

  def scoring_dice_count
    scoring_dice_count = 0
    dice_dup = @dice.dup
    
    return 6 if straight?
    
    triplets.each do |triplet_num|
      scoring_dice_count += 3
      3.times{dice_dup.delete_once(triplet_num)}
    end
    
    scoring_dice_count += dice_dup.find_all{|d| d == 1 || d == 5}.size
    scoring_dice_count
  end
  
  # Returns Array of DiceGroup objects
  def scoring_options
    scoring_options = []
    
    scoring_options << DiceGroup.new(@dice) if straight?
    
    triplets.each do |triplet_num|
      scoring_options << DiceGroup.new([triplet_num,triplet_num,triplet_num])
    end
    
    single_scoring_dice.each do |num|
      scoring_options << DiceGroup.new([num])
    end
    
    scoring_options
  end
  
  # boolean
  def straight?
    @dice.size == 6 && @dice.sort == [1,2,3,4,5,6]
  end
  
  private
  
  # All the dice that score singly. 1s and 5s.
  # Returns Array of Die objects
  def single_scoring_dice
    @dice.find_all {|d| d == 1 || d == 5 }
  end
  
  # returns an empty or 1- or 2-element array of
  # numbers that appear 3 times in the dice group
  def triplets
    return [] unless @dice.size >= 3

    triplets = []
    1.upto(6) do |num|
      count_num = @dice.find_all {|die| die.value == num}.size
      if count_num >= 3
        triplets << num
      end
      if count_num == 6
        triplets << num
      end
    end
    
    triplets
  end
  
end