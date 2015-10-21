require "./lib/station.rb"

class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :entry_station, :history

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @history = Array.new
  end


  def top_up(value)
    message = "Can not top up, balance exceeds maximum balance of #{MAX_BALANCE}"
    fail message if balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Minimum balance is #{Oystercard::MIN_BALANCE}"
    fail message if balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    history << journey = { entry_station => exit_station }
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
