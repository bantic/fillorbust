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
  
  # Returns Array of arrays of Die objects
  def scoring_options
    scoring_options = []
    
    scoring_options << @dice.dup if straight?
    
    triplets.each do |triplet|
      scoring_options << [Die.new(triplet),
                          Die.new(triplet),
                          Die.new(triplet)]
    end
    
    single_scoring_dice.each do |num|
      scoring_options << [Die.new(num)]
    end
    
    scoring_options
  end
  
  private
  
  # All the dice that score singly. 1s and 5s.
  # Returns Array of Die objects
  def single_scoring_dice
    @dice.find_all {|d| d == 1 || d == 5 }
  end
  
  # boolean
  def straight?
    @dice.size == 6 && @dice.sort == [1,2,3,4,5,6]
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
  
  # returns fixnum
  def scoring_dice_count
    count = 0
    count += 6 if straight?
    count += 3 * triplets.size
    count += single_scoring_dice.size
  end
  
end