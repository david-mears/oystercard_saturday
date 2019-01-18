require_relative 'journey'

class OysterCard
attr_reader :balance, :journeys, :journey_class

DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE, journey_class = Journey)
    @balance = balance
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise error_message if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def error_message
    "ERROR!! The Maximum balance is £#{MAXIMUM_BALANCE}"
  end

  def balance_exceeds_limit?(amount)
    (amount + balance) > MAXIMUM_BALANCE
  end

  def touch_in(entry_station)
    fail "Please top up" if balance < MINIMUM_BALANCE
    @journeys << journey_class.new(entry_station)
  end

  def touch_out(exit_station)
    unless @journeys[-1].in_journey?
      @journeys << journey_class.new(nil)
    end
    @journeys[-1].exit_station = exit_station
    deduct(@journeys[-1].fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
