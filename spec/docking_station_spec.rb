require "docking_station"

describe DockingStation do

  docking_station = DockingStation.new(1)
  let(:bike) {double(:bike)}
  
  it "returns a bike object" do
    bike = double(:bike , working?: true)
    expect(bike).to be_working
  end
  
  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it 'has a variable capacity' do
    docking_station = DockingStation.new(50)
    50.times { docking_station.dock double(:bike) }
    expect{ docking_station.dock double(:bike) }.to raise_error 'Docking station full'
  end

  it 'can be reported broken' do
    subject.report_broken
    expect(subject).to be_broken
  end

  it 'releases working bikes' do
    bike = double(:bike, broken?: false)
    subject.dock bike
    expect(subject.release_bike).to be bike
  end

  it 'does not release broken bikes' do
    docking_station_broken_bike = DockingStation.new
    bike = double(:bike, broken?: true)
    docking_station_broken_bike.dock bike
    expect {subject.release_bike}.to raise_error 'No bikes available'
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it "docks a bike in the docking station" do
    bike = double(:bike)
    subject.dock(bike)
    expect(subject.dock(bike)).to include bike
  end

  it 'raises an error when full' do
    subject.capacity.times { subject.dock double :bike }
    expect { subject.dock double(:bike) }.to raise_error 'Docking station full'
  end

  it { is_expected.to respond_to :release_bike }

  it 'releases a bike' do
    # remember subject == DockingStation.new
    DockingStation::DEFAULT_CAPACITY.times do
      subject.dock double(:bike)
    end
    20.times { subject.release_bike }
    expect { subject.release_bike }.to raise_error 'No bikes available'
  end

end




