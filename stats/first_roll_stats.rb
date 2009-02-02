require File.dirname(__FILE__) + '/../fillorbust'

OUTPUT = false

fills = 0
busts = 0
straights = 0
scoring_dice = []
ROLLS = 100_000
start_at = Time.now

ROLLS.times do

  dg = DiceGroup.new
  if dg.fill?
    fills += 1
    puts "fill: #{dg}" if OUTPUT
  end
  if dg.bust?
    puts "bust: #{dg}" if OUTPUT
    busts += 1
  end
    
  if dg.straight?
    puts "straight: #{dg}" if OUTPUT
    straights += 1
  end
  
  scoring_dice << dg.scoring_dice_count
end

puts "#{ROLLS} Rolls:"
puts "Fills: #{fills}, Straights: #{straights}, Busts: #{busts}"
puts "Average # of scoring dice: #{scoring_dice.average}"
puts "Took #{Time.now - start_at}s"