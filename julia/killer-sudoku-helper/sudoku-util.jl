ONE_TO_NINE = 2:1:9

function combinations_in_cage(target::Int64, size::Int64, constraints::Vector{Int64}=Vector{Int64}(undef, 0))::Vector{Vector{Integer}}
    if size == 1
        if !(target in constraints) && target > 0
            return [[target]]
        else
            return [[]]
        end
    else
        nested_candidates = [[
                vcat(cand, [x]) for cand in combinations_in_cage(target-x, size-1, [constraints; [x]]) if length(cand) > 0
            ] for x in ONE_TO_NINE if !(x in constraints) && x <= target]
        candidates = reduce(vcat, nested_candidates; init=[])
        sorteds = [sort(cand) for cand in candidates]
        unique!(sorteds)
        sort!(sorteds)
        sorteds
    end
end
