require 'journey'
require 'station'
require 'oystercard'

describe Journey do

  subject(:journey) { described_class.new }
  let(:oystercard) { double(:oystercard, :balance => 10, :low_balance? => false, :deduct => :balance) }
  let(:entry_station) { double(:entry_station, :name => "Paddington", :zone => "1") }
  let(:exit_station) { double(:exit_station, :name => "Kings X", :zone => "2") }

  it "create an empty array when initialized" do
    expect(journey.history).to be_empty
  end

  it "should change status to in journey when touched in" do
    journey.touch_in(entry_station, oystercard)
    expect(journey).to be_in_journey
  end

  it "should change status to not in journey when touched out" do
    journey.touch_in(entry_station, oystercard)
    journey.touch_out(exit_station, oystercard)
    expect(journey).not_to be_in_journey
  end

  it 'should store the entry station into #@entry_station' do
    journey.touch_in(entry_station, oystercard)
    expect(journey.entry_station).to eq entry_station
  end

  it 'should reset the entry_station to nil when touching out' do
    journey.touch_in(entry_station, oystercard)
    journey.touch_out(exit_station, oystercard)
    expect(journey.entry_station).to eq nil
  end

  it 'stores a journey in the history array' do
    journey.touch_in(entry_station, oystercard)
    journey.touch_out(exit_station, oystercard)
    expect(journey.history).not_to be_empty
  end



end
