#!/usr/bin/env bash

main () {
    # Leading `/` in pattern indicates "replace all such patterns, not just one"
    inp=${1//" "/""}
    echo "inp is $inp" >> logfile
    length=${#inp}
    echo "Length is $length" >> logfile
    if [[ "$length" -lt 2 ]]; then
        echo "Length less than 2" >> logfile
        echo "false"
        exit 0
    fi

    # https://stackoverflow.com/a/18710850/1040915
    pat=".*[^0-9].*"
    if [[ $inp =~ $pat ]]; then
        echo "Non-numeric characters" >> logfile
        echo "false"
        exit 0
    fi

    sum=0;
    for idx in $( eval echo {0..$(( length - 1 ))} )
    do
        echo "Checking the $idx index" >> logfile
        # Luhn starts from the right!
        revd_idx=$(( $length - $(( $idx + 1 )) ))
        num=${inp:revd_idx:1}
        echo "num is $num" >> logfile
        if [[ $(( $idx % 2 )) -eq 1 ]]; then
            # TODO - check how modulo actually works in bash
            num=$(( "$num" * 2 ))
            echo "Doubled num to $num because $idx is odd" >> logfile
            if [[ $(echo "$num > 9" | bc -l) -eq 1 ]]; then
              echo "Reducing $num by 9" >> logfile
              num=$(( "$num" - 9 ))
            fi
        fi
        sum=$(( $sum + $num ))
        echo "Added $num, now sum is $sum" >> logfile
    done

    echo "Total sum is $sum" >> logfile
    if [[ $(( $sum % 10 )) -eq 0 ]]; then
        echo "So, valid" >> logfile
        echo "true"
        exit 0
    else
        echo "So, invalid" >> logfile
        echo "false"
        exit 0
    fi    

}

main "$@"
