# A line of people at an amusement park ride
# There is a front to the line, as well as a back.
# People may leave the line whenever they see fit and those behind them take their place.
class Line
  attr_accessor :members

  def initialize
    self.members = []
  end

  def join(person)
    self.members.unshift(person)
  end

  def leave(person)
    self.members.delete(person)
  end

  def front
    self.members[-1]
  end

  def middle
    # don't need to call 'self' on right-hand side of assignment
    middle_index = ((members.length - 1) / 2).round
    self.members[middle_index]
  end

  def back
    self.members[0]
  end

  def search(person)
    index = members.index(person)
    person if (index != nil)
  end

  private

  def index(person)
    self.members.index(person) # This method seems redundant since a built-in Ruby #index method exists
  end

end
