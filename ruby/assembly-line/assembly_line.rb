class AssemblyLine

  BASE_RATE = 221

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    BASE_RATE * @speed * success_rate()
  end

  private def success_rate
    if @speed < 5
      success_rate = 1.0
    elsif @speed < 9
      success_rate = 0.9
    elsif @speed < 10
      success_rate = 0.8
    else
      success_rate = 0.77
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor()
  end
end
