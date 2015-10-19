

class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  attr_reader :balance

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(value)
    raise "Can not top up, balance exceeds maximum balance of #{MAX_BALANCE}" if balance + value > MAX_BALANCE
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end
end
