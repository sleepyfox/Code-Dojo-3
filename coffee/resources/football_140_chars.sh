awk '/[0-9]/{x=$7-$9;print (x<0?-x:x),$2}' football.dat|sort -n|head -1
