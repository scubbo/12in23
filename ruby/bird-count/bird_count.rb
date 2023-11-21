class BirdCount

  LAST_WEEK = [0, 2, 5, 3, 7, 8, 4]

  def self.last_week
    LAST_WEEK
  end

  def initialize(birds_per_day)
    @counts = birds_per_day
  end

  def yesterday
    @counts[-2]
  end

  def total
    @counts.sum
  end

  def busy_days
    @counts.count { |count| count >= 5 } 
  end

  def day_without_birds?
    @counts.any? { |count| count == 0 }
  end
end
