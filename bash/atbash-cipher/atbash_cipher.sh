#!/usr/bin/env bash

ALPHABET="abcdefghijklmnopqrstuvwxyz"

main() {
    echo "Starting" >> logfile
    s=""
    while read -n1 char; do
        echo "Reading $char" >> logfile
        s="$s""$(encrypt_char $char)"
    done < <(echo $(echo $2 | tr '[:upper:]' '[:lower:]'))
    if [[ "$1" == "encode" ]]; then
        echo "Encoding into chunks" >> logfile
        out_string=""
        num_chunks=$((${#s} / 5))
        echo "Num_chunks is $num_chunks" >> logfile
        # https://stackoverflow.com/a/17181832/1040915
        for chunk_num in $( eval echo {0..$num_chunks} )
        do
            echo "Operating on $chunk_num" >> logfile
            idx=$(("$chunk_num" * 5))
            out_string="$out_string""${s:idx:5}"" "
        done
        echo -e $out_string | sed -e 's/[[:space:]]*$//'
    else
        echo $s
    fi
}

encrypt_char () {
    echo "Calling encrypt_char for $1" >> logfile
    idx=$(find_index_of_character $1)
    echo "Idx is $idx" >> logfile
    if [[ "$idx" -eq -1 ]]; then
        # Only some characters should be passed through unchanged
        if [[ " 1234567890" == *"$1"* ]]; then
            echo $1
        else
            echo ""
        fi
    else
        encrypted_index=$((25 - $idx))
        echo "Encrypted Index is $encrypted_index" >> logfile
        encrypted_letter=${ALPHABET:encrypted_index:1}
        echo "Encrypted letter is $encrypted_letter" >> logfile
        echo $encrypted_letter
    fi
}

find_index_of_character () {
    char=$1
    for idx in {0..25}
    do
        if [[ "${ALPHABET:idx:1}" == "$char" ]]; then
            echo $idx
            return
        fi
    done
    echo -1
}

main "$@"