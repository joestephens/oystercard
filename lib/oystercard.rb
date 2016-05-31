class Oystercard

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_FARE = 1

  attr_reader :balance, :journey_log

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journey_log = []
    @current_journey = {}
  end

  def top_up(money)
    fail "Card is at its limit of #{LIMIT}." if at_limit?(money)
    @balance += money
  end

  def touch_in(station)
    fail "Balance is below minimum fare." if under_min?
    @current_journey[:entry] = station
  end

  def touch_out(station)
    deduct
    @current_journey[:exit] = station
    @journey_log << @current_journey
    @current_journey = {}
  end

  def in_journey?
    @current_journey.empty? ? false : true
  end

  private

  def at_limit?(money)
    balance + money > LIMIT
  end

  def deduct(money=MIN_FARE)
    @balance -= money
  end

  def under_min?
    @balance < MIN_FARE
  end

end
