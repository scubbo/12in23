"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    if length(input) < 26
        return false
    end

    letter_set = Set([Char(i) for i in 97:122])
    for c in input
        delete!(letter_set, lowercase(c))
        # If we wanted to hyperoptimize, there's no need to check this until 26 characters have been processed
        if length(letter_set) == 0
            return true
        end
    end

    false
end

