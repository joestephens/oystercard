class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journeys

MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "balance cannot exceed #{MAXIMUM_BALANCE}" if exceed(money)
    @balance += money
  end

  def touch_in(station)
    fail 'Balance too low to enter' if low_balance
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    deduct()
    @exit_station = station
    @entry_station = nil
    @journeys[:exit_station] = station
  end



  private

  def exceed(money)
    money + balance > MAXIMUM_BALANCE
  end

  def low_balance
    balance < MINIMUM_FARE
  end

  def deduct()
    @balance -= MINIMUM_FARE
  end

end

