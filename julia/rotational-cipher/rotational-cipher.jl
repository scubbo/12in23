function rotate(n::Int64, s::String)
    # Is there a simpler [...].join("")?
    [rotate(n, c) for c in s] |> a -> join(a, "")
end

LOWERS = 1:26 .|> i -> Char(i+96)
UPPERS = 1:26 .|> i -> Char(i+64)

function rotate(n::Int64, c::Char)
    if !(isletter(c))
        return c
    end
    chars = isuppercase(c) ? UPPERS : LOWERS
    orig_index = findfirst(x->x==c, chars)
    new_index=(orig_index+n)%26
    # Blech...must be a better way to do this!?
    if new_index == 0
        new_index = 26
    end
    chars[new_index]
end

macro R13_str(s)
    rotate(13, s)
end

# This was my first attempt at Bonus B, which fai
# for i in 1:26
#     eval(string("macro R", i, "_str(s)\nrotate($i, s)\nend"))
# end

# This was adapted from another solution and works
# for n in 0:26
#     name = Symbol("R", n, "_str")
#     eval(:(macro $name(s) rotate($n, s) end))
# end

# But this doesn't
# for n in 0:26
#     eval(:(macro Symbol("R", n, "_str")(s) rotate($n, s) end))
# end