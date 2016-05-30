class Oystercard

  DEFAULT_BALANCE=0
  LIMIT=90
  MIN_FARE=1

  attr_reader :balance, :stations

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @stations = []
  end

  def top_up(money)
    fail "Card is at its limit of #{LIMIT}." if at_limit?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in(station)
    fail "Balance is below minimum fare." if @balance < MIN_FARE
    @stations << station
  end

  def touch_out
    @stations.pop
  end

  def in_journey?
    @stations.empty? ? false : true
  end

  private

  def at_limit?(money)
    balance+money > LIMIT
  end

end
