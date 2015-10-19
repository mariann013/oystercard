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

end
