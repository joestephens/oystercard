class Oystercard

  DEFAULT_BALANCE=0
  LIMIT=90

  attr_reader :balance

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    fail "Card is at its limit of #{LIMIT}." if at_limit?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  private

  def at_limit?(money)
    balance+money > LIMIT
  end

end
