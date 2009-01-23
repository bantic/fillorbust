require File.dirname(__FILE__) + '/die'

class DiceGroup
  DEFAULT_DICE_NUMBER = 6
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
      raise InvalidArgumentError
    end
  end

  def bust?
    scoring_dice.empty?
  end
  
  def scoring_dice
    scoring_dice = []
    
    triplets.each do |triplet|
      3.times {scoring_dice << Die.new(triplet)}
    end
    
    scoring_dice << @dice.find_all {|d| d.value == 1}
    scoring_dice << @dice.find_all {|d| d.value == 5}
    scoring_dice.flatten!
  end
  
  def score
    
  end
  
  private

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