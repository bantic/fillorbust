require File.dirname(__FILE__) + '/../fillorbust'
require 'benchmark'

ROLLS = 10_000

Benchmark.bm do |x|
  x.report("DiceGroup.new") { ROLLS.times do; dg = DiceGroup.new; end }
  x.report("DiceGroup.new + fill?") do
    ROLLS.times do
      dg = DiceGroup.new
      dg.fill?
    end
  end
  x.report("DiceGroup.new + fill? + bust?") do
    ROLLS.times do
      dg = DiceGroup.new
      dg.fill?
      dg.bust?
    end
  end
  x.report("DiceGroup.new + fill? + bust? + straight?") do
    ROLLS.times do
      dg = DiceGroup.new
      dg.fill?
      dg.bust?
      dg.straight?
    end
  end
  x.report("DiceGroup.new + fill? + bust? + straight? + scoring_options") do
    ROLLS.times do
      dg = DiceGroup.new
      dg.fill?
      dg.bust?
      dg.straight?
      dg.scoring_options
    end
  end
  x.report("DiceGroup.new + fill? + bust? + straight? + scoring_options + scoring_dice_count") do
    ROLLS.times do
      dg = DiceGroup.new
      dg.fill?
      dg.bust?
      dg.straight?
      dg.scoring_options
      dg.scoring_dice_count
    end
  end
end