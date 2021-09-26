require "docking_station"

describe DockingStation do

  docking_station = DockingStation.new(1)
  let(:bike) {double("Bike", :working? => true)}

  it { is_expected.to respond_to :release_bike }

  it "returns a bike object" do
    bike = Bike.new
    expect(bike).to be_working
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it "docks a bike in the docking station" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.dock(bike)).to include bike
  end

  it "raises an error if docking station is full" do
    bike = Bike.new
    DockingStation::DEFAULT_CAPACITY.times do
      subject.dock(bike)
    end
    expect {subject.dock(bike)}.to raise_error "Docking station full"
  end
  
  it 'releases a bike' do
    # remember subject == DockingStation.new
    DockingStation::DEFAULT_CAPACITY.times do
      subject.dock Bike.new
    end
    20.times { subject.release_bike }
    expect { subject.release_bike }.to raise_error 'No bikes available'
  end
  
  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

end

describe 'initialization' do
  it 'has a variable capacity' do
    docking_station = DockingStation.new(50)
    50.times { docking_station.dock Bike.new }
    expect{ docking_station.dock Bike.new }.to raise_error 'Docking station full'
  end
end



