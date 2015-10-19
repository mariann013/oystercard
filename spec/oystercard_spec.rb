require "./lib/oystercard.rb"

describe Oystercard do
let (:oystercard) {Oystercard.new}

it "has a balance " do
  expect(oystercard.balance).to eq 0
end



end
