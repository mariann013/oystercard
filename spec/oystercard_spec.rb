require "./lib/oystercard.rb"

describe Oystercard do

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

  it 'should deduct money' do
    oystercard = Oystercard.new(20)
    balance = oystercard.balance
    fare = 2.30
    expect(oystercard.deduct(fare)).to eq (balance - fare)
  end

  it "should change status to in journey when tocuhed in" do
    oystercard = Oystercard.new(10)
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

  it "should change status to not in journey when tocuhed out" do
    oystercard = Oystercard.new(10)
    oystercard.touch_out
    expect(oystercard).not_to be_in_journey
  end

  it 'should raise an error if insufficient funds' do
    oystercard = Oystercard.new(0.50)
    msg = "Insufficient funds. Minimum balance is #{Oystercard::MIN_BALANCE}"
    expect {oystercard.touch_in}.to raise_error msg
  end
end
