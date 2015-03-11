awk '/[12][0-9]+\ /{print $3-$4,$1 "-" $2}' weather.dat|sort -n|head -1
