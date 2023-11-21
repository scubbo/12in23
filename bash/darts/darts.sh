#!/usr/bin/env bash

main () {
    if [ "$#" -ne 2 ]; then
        echo "Illegal number of parameters"
        exit 1
    fi

    number_re='^[0-9.-]+$'
    for arg in $1 $2
    do
        if ! [[ $arg =~ $number_re ]] ; then
            echo "error: Not a number" >&2; exit 1
        fi
        # case $arg in
        #     ''|*[!0-9]*) echo "not a number"; exit 1 ;;
        #     *) ;;
        # esac
    done


    first_dist=${1/"-"/"_"}
    echo "first_dist is $first_dist" >> logfile
    second_dist=${2/"-"/"_"}
    echo "second_dist is $second_dist" >> logfile
    squared_distance=$(echo "($1 * $1) + ($2 * $2)" | bc)
    if (( $(echo "$squared_distance > 100" | bc -l) )); then
      echo "0";
      return;
    elif (( $(echo "$squared_distance > 25" | bc -l) )); then
      echo "1";
      return;
    elif (( $(echo "$squared_distance > 1" | bc -l) )); then
      echo "5";
      return;
    else
      echo "10";
      return;
    fi
}

main "$@"
