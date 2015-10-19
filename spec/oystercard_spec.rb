require "./lib/oystercard.rb"

describe Oystercard do

subject(:oystercard) {Oystercard.new}

it "has a balance " do
  expect(oystercard.balance).to eq 0
end

it { is_expected.to respond_to(:top_up).with(1).argument }

it 'can update a balance' do
  value = 20
  oystercard.top_up(value)
  expect(oystercard.balance).to eq value
end

it "should raise an error when the balance exceeds the limit" do
  value = 10 + Oystercard::MAX_BALANCE
  message = "Can not top up, balance exceeds maximum balance of #{Oystercard::MAX_BALANCE}"
  expect {oystercard.top_up(value)}.to raise_error message

end

end
