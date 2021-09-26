require_relative "bike"

class DockingStation
  DEFAULT_CAPACITY = 20
  attr_accessor :capacity

  def initialize(capacity=DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    fail 'No bikes available' if broken?
    fail 'No bikes available' if empty?
    @bikes.pop
  end

  def dock(bike)
    fail 'Docking station full' if full?
    @bikes << bike
  end
  
  def report_broken
    @broken = true
  end

  def broken?
    @broken
  end

  private

  attr_reader :bikes

  def full?
    @bikes.count >= @capacity
  end

  def empty?
    @bikes.empty?
  end

end