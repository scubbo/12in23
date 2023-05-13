"""
    count_nucleotides(strand)

The count of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
LEGAL_VALUES = ['A', 'C', 'G', 'T']

function count_nucleotides(strand)
    start_value = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    reduce(red, strand; init=start_value)
end

function red(d, elem)
    if !(elem in LEGAL_VALUES)
        throw(DomainError(d))
    end
    d[elem] = get(d, elem, 0) + 1
    d
end
