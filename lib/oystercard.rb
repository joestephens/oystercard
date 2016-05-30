class Oystercard

  DEFAULT_BALANCE=0
  LIMIT=90
  MIN_FARE=1

  attr_reader :balance

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @in_use = false
  end

  def top_up(money)
    fail "Card is at its limit of #{LIMIT}." if at_limit?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    fail "Balance is below minimum fare." if @balance < MIN_FARE
    @in_use = true
    in_journey?
  end

  def touch_out
    @in_use = false
    in_journey?
  end

  def in_journey?
    @in_use
  end

  private

  def at_limit?(money)
    balance+money > LIMIT
  end

end
