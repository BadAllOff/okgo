class EventualValueMatcher
  def initialize(&block)
    @block = block
  end

  def ==(value)
    @block.call == value
  end
end

def eventual_value(&block)
  EventualValueMatcher.new(&block)
end