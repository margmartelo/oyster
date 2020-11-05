class Oystercard
  attr_reader :balance
  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "you have exeeded your max balance of #{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    raise "not enough balance" if balance < MIN_FARE
    @in_journey = true
    @station = station
  end

  def touch_out
    deduct(MIN_FARE)
    # raise 'not in journey' if @in_journey == false
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
