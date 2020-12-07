#!/bin/bash

i=1
while IFS= read -r line; do
    i=$(($i+1))

    out=$(steghide extract -sf $1 -p "$line" 2>&1)
    if [[ "$(echo "$i%1000"|bc )" == "0" ]]; then
      printf "Now cracking: $line\r"
    fi
    
    if [[ *"$out"* != *"steghide: could not extract any data with that passphrase!"* ]];then

      echo "Password found!:"$line
      echo $out
      exit 0;


    fi
done < "/dev/stdin"
