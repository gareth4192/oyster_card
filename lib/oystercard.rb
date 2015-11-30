
class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  attr_reader :balance, :max_limit, :in_use, :entry_station

  def initialize(max_limit = MAX_LIMIT)
    @balance = 0
    @max_limit = max_limit
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "Max limit exceeded #{max_limit}" if (amount + balance) > max_limit
    @balance += amount
  end

   def in_journey?
     @entry_station == nil ? false : true
   end

  def touch_in(entry_station)
    fail "insufficient funds: #{balance}" if balance < MIN_LIMIT
    @entry_station =  entry_station
  end

  def touch_out
    deduct(MIN_LIMIT)
    #@entry_stations.pop
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
