require "oystercard.rb"
require "station.rb"
require "journey.rb"

describe Oystercard do
  let(:entry_station) { double(:entry_station, :name => "Paddington", :zone => "1") }
  let(:exit_station) { double(:exit_station, :name => "Kings X", :zone => "2") }
  let(:journey) { double(:journey, :touch_in => entry_station, :touch_out => entry_station) }

  # subject(:oystercard) {Oystercard.new(20)}
  # let(:value) { 20 }
  it "has a balance " do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can update a balance' do
    oystercard = Oystercard.new
    value = 20
    oystercard.top_up(value)
    expect(oystercard.balance).to eq value
  end

  it "should raise an error when the balance exceeds the limit" do
    oystercard = Oystercard.new
    value = 10 + Oystercard::MAX_BALANCE
    message = "Can not top up, balance exceeds maximum balance of #{Oystercard::MAX_BALANCE}"
    expect {oystercard.top_up(value)}.to raise_error message
  end
  #
  # it "should change status to in journey when touched in" do
  #   oystercard = Oystercard.new(10)
  #   oystercard.touch_in(entry_station)
  #   expect(oystercard).to be_in_journey
  # end

  # it "should change status to not in journey when touched out" do
  #   oystercard = Oystercard.new(10)
  #   oystercard.touch_out(exit_station)
  #   expect(oystercard).not_to be_in_journey
  # end

  it 'should raise an error if insufficient funds' do
    oystercard = Oystercard.new
    msg = "Insufficient funds. Minimum balance is #{Oystercard::MIN_BALANCE}"
    expect {journey.touch_in(entry_station, oystercard)}.to raise_error msg
  end

  it "should deduct fare when touched out" do
    oystercard = Oystercard.new(10)
    expect {journey.touch_out(exit_station)}.to change {oystercard.balance}.by(-Oystercard::MIN_BALANCE)
  end

  # it 'should return entry station to user' do
  #   oystercard = Oystercard.new(10)
  #   oystercard.touch_in(entry_station)
  #   expect(oystercard.entry_station).to eq entry_station
  # end

  it "should return empty array if no journey has been made" do
    oystercard = Oystercard.new(10)
    expect(oystercard.history).to be_empty
  end

  # it 'should reset the entry_station to nil when touching out' do
  #   oystercard = Oystercard.new(10)
  #   oystercard.touch_in(entry_station)
  #   oystercard.touch_out(exit_station)
  #   expect(oystercard.entry_station).to eq nil
  # end

  # it 'stores a journey in the history array' do
  #   oystercard = Oystercard.new(10)
  #   oystercard.touch_in(entry_station)
  #   oystercard.touch_out(exit_station)
  #   expect(oystercard.history).not_to be_empty
  # end

  it "entry station responds to zone method" do
    oystercard = Oystercard.new(10)
    oystercard.touch_in(entry_station)
    expect(oystercard.entry_station).to respond_to :zone
  end

  it "exit station responds to zone method" do
    oystercard = Oystercard.new(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.history[0][entry_station].zone).to eq "2"
  end

end
