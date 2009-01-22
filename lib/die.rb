class Die
  attr_accessor :value
  def initialize(value=nil)
    @value = value
    roll! unless @value
  end
  
  def roll!
    @value = rand(6) + 1
  end
  
  def ==(other)
    @value == other.value
  end
end