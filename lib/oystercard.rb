require_relative 'station'
require_relative 'journey.rb'

class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :entry_station, :history

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @journey = Journey.new
  end

  def top_up(value)
    message = "Can not top up, balance exceeds maximum balance of #{MAX_BALANCE}"
    fail message if balance + value > MAX_BALANCE
    @balance += value
  end

  def low_balance?
    @balance < MIN_BALANCE
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end

# oystercard = Oystercard.new(0.50)
# oystercard.balance
# 0.5 < Oystercard::MIN_BALANCE
