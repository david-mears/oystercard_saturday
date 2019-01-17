require_relative 'journey'

class OysterCard
attr_reader :balance, :journeys

DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
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
    @journeys << Journey.new(entry_station)
  end

  def touch_out(exit_station)
    if !in_journey?
      @journeys << Journey.new(nil)
    end
    @journeys[-1].exit_station = exit_station
    deduct(@journeys[-1].fare)
  end

  def in_journey?
    @journeys[-1].in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
