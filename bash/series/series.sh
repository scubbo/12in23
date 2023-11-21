#!/usr/bin/env bash

main () {
    sequence=$1
    sequence_length=${#sequence}
    subsequence_length=$2

    if [[ $subsequence_length -eq 0 ]]; then
        echo "slice length cannot be zero"
        exit 1
    fi

    if [[ $subsequence_length -lt 0 ]]; then
        echo "slice length cannot be negative"
        exit 1
    fi

    if [[ $sequence_length -eq 0 ]]; then
        echo "series cannot be empty"
        exit 1
    fi

    if [[ $subsequence_length -gt $sequence_length ]]; then
        echo "slice length cannot be greater than series length"
        exit 1
    fi

    if [[ $subsequence_length -eq $sequence_length ]]; then
      echo $sequence
    else
        for start in $(eval echo {0..$(( $sequence_length - $subsequence_length - 1 ))})
        do
            echo -n ${sequence:start:subsequence_length}" "
        done
        echo -n ${sequence:$(( $sequence_length - $subsequence_length)):subsequence_length}
    fi

}

main "$@"
