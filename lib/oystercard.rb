class OysterCard
attr_reader :balance, :in_journey

DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise error_message if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    raise "Insufficient Funds" if (amount > @balance)
    @balance -= amount
  end

  def error_message
    "ERROR!! The Maximum balance is £#{OysterCard::MAXIMUM_BALANCE}"
  end

  def balance_exceeds_limit?(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  def touch_in
    @in_journey = true
  end
  
  def in_journey?
    in_journey
  end

  def touch_out
    @in_journey = false
  end

end
