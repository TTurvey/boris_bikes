# frozen_string_literal: true

require_relative "bike"


class DockingStation
  attr_reader :bike
  DEFAULT_CAPACITY = 20

  def initialize
    @capacity = 20
    @bikes = []
  end

  def release_bike
    if @bikes.empty?
        fail "No bikes available"
    else
        @bikes.pop
    end
  end

  def dock(bike)
    if full?
      fail "Docking station full" 
    else
      @bike = bike
      @bikes.push(bike)
    end
  end
  
  private

  def full?
    @bikes.count >= DEFAULT_CAPACITY
  end

  def empty?
    @bikes.empty?
  end

end