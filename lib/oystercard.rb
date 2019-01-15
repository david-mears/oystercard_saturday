class OysterCard
attr_reader :balance, :in_journey

DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 2

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @origin_station = ""
  end

  def top_up(amount)
    raise error_message if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def error_message
    "ERROR!! The Maximum balance is £#{OysterCard::MAXIMUM_BALANCE}"
  end

  def balance_exceeds_limit?(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  def touch_in(origin_station)
    fail "Please top up" if @balance < MINIMUM_BALANCE

    @in_journey = true
    @origin_station = origin_station
  end

  def in_journey?
    in_journey
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
