import Base: +, -, ==
import Dates: Minutes
using Printf

struct Clock
    hour
    minute
    function Clock(hour, minute)
        while minute < 0
            minute += 60
            hour -= 1
        end
        hour += minute ÷ 60
        minute = minute % 60
        while hour < 0
            hour += 24
        end
        new(hour % 24, minute)
    end
end

function ==(c1::Clock, c2::Clock)
    c1.hour == c2.hour && c1.minute == c2.minute
end

function +(c::Clock, m::Minute)
    Clock(c.hour, c.minute + m.value)
end

function -(c::Clock, m::Minute)
    Clock(c.hour, c.minute - m.value)
end

function Base.show(io::IO, clock::Clock)
    @printf(io, "\"%02d:%02d\"", clock.hour, clock.minute)
end