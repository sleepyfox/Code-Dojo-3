awk 'BEGIN{y=0;m=0;r=99}NR>8{if($3-$4<r){r=($3-$4);y=$1;m=$2}}END{print "min is ",r," year:",y," month:",m}'
