function transform(input::AbstractDict)
    out = Dict()
    for (score, letters) in pairs(input)
        for letter in letters
            out[lowercase(letter)] = score
        end
    end
    out
end

