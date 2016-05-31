require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class Oystercard
  attr_reader :balance, :log
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(log = JourneyLog.new)
    @balance = 0
    @log = log
  end

  def top_up(amount)
    fail "Cannot top up past £#{LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    deduct if @log.in_journey?
    fail "Insufficient balance" if @balance < MIN_BALANCE
    @log.start(station)
  end

  def touch_out(station)
    @log.finish(station)
    deduct
  end

  private
    def deduct
      @balance -= @log.journey.fare
    end
end
