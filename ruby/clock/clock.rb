class Clock

    attr_reader :hour, :minute

    def initialize(hour: 0, minute: 0)
        @minute = minute % 60
        @hour = (hour + (minute / 60)) % 24
    end

    def to_s
        "#{@hour.to_s.rjust(2, '0')}:#{@minute.to_s.rjust(2, '0')}"
    end

    def +(other_clock)
        Clock.new(hour: @hour + other_clock.hour, minute: @minute + other_clock.minute)
    end

    def -(other_clock)
        Clock.new(hour: @hour - other_clock.hour, minute: @minute - other_clock.minute)
    end

    def ==(o)
        o.hour == @hour && o.minute == @minute
    end
end