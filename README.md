# Code Kata Munge

_(Otherwise known as the 'temperature spread kata')_

This is a simple kata involving the reading of data from files and the finding of aggregate data from those files.

In the first example we have data from a weather station at Heathrow airport. The challenge is simple:

* Find the year and month that has the smallest spread between the maximum and minimum temperature recorded for that month

The data file can be found [here](football.dat).

Once this is complete, there is another, similar, problem to solve:

* Given some football scores data (Premier League 2001/2), find the team that had the minimum spread between goals for and goals against

The data file can be found [here](heathrow-weather-data.txt).

Different versions of sample code solutions for this kata can be found in the following folders:

* [Python](/python)
* [CoffeeScript](/coffee)

The source of the kata is Dave Thomas of the Pragmatic Programmers and you can find the original write up from 2007 [here](http://codekata.com/kata/kata04-data-munging/). You can find out more about the Edinburgh and London Code Dojos at their home-pages  [Edinburgh](http://www.meetup.com/Edinburgh-Code-Dojo/) and [London](http://www.meetup.com/London-Code-Dojo/)

# License
The code samples are licensed under the CC-SA-NC-4.0 license, as shown in the [LICENSE](/LICENSE) file.

## Easter egg

Shortest solution found so far, keeping input filename the same: (70 chars)

```bash
awk 'NR>7{print $3-$4,$1,$2}' heathrow-weather-data.txt|sort -n|head -1
```
