import Base: ==

struct ISBN
    s
    function ISBN(s)
        filtered_string = s |> (t -> filter(x -> isdigit(x) || x == 'X', t))
        if !is_valid(filtered_string)
            throw(DomainError(filtered_string))
        end
        new(filtered_string)
    end
end

function is_valid(s)
    total = 0
    if length(s) != 10
        throw(DomainError("ISBNs must be 10 characters long: $s"))
    end
    # I wish I could do this fully with pipes, but
    # can't see how to pipe out of `enumerate`
    for (i, x) in enumerate(s)
        if x == 'X' && i != 10
            throw(DomainError("X is only valid as a checksum: $s"))
        end
        total += (10-(i-1))*myparse(x)
    end
    (total % 11) == 0
end

function myparse(c::Char)
    if isdigit(c)
        return parse(Int, c)
    end
    if c == 'X'
        return 10
    end
    raise(DomainError(c))
end

function ==(isbn1::ISBN, isbn2::ISBN)
    isbn1.s == isbn2.s
end