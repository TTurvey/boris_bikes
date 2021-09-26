# frozen_string_literal: true

require "docking_station"

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it "returns a bike object" do
    bike = Bike.new
    expect(bike).to be_working
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it { is_expected.to respond_to(:bike) }

  describe '#dock' do
    it "docks a bike in the docking station" do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.bike).to(eq(bike))
    end
    
    it "raises an error if docking station is full" do
      bike = Bike.new
      20.times { subject.dock(bike) }
      expect {subject.dock(bike)}.to raise_error "Docking station full"
    end
  end

  describe '#release_bike' do
    it 'releases a bike' do
      # Let's not dock a bike first:
      # remember subject == DockingStation.new
      bike = Bike.new
      20.times { subject.dock(bike) }
      20.times { subject.release_bike }
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end

end