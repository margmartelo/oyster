class Oystercard
  attr_reader :balance, :entry_station
  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def in_journey?
    !!entry_station ##-> this is forced into a boolean context (true), and then negated (false), and then negated again (true)
  end

  def top_up(amount)
    raise "you have exeeded your max balance of #{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    raise "not enough balance" if balance < MIN_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    # raise 'not in journey' if @in_journey == false
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
