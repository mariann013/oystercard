require_relative 'oystercard'

class Journey

attr_reader :history, :entry_station

  def initialize
    @history = []
  end

  def touch_in(entry_station, oystercard)
    message = "Insufficient funds. Minimum balance is #{Oystercard::MIN_BALANCE}"
    fail message if oystercard.low_balance?
    @entry_station = entry_station
  end

  def touch_out(exit_station, oystercard)
    oystercard.deduct(Oystercard::MIN_BALANCE)
    history << { @entry_station => exit_station }
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

end

# card = Oystercard.new
# journey = Journey.new
# journey.touch_in('station', card)
# journey.touch_out('station2', card)
