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
    case other
    when Fixnum
      @value == other
    when Die
      @value == other.value
    end
  end
  
  def <=>(other)
    @value <=> other.value
  end
end