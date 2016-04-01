PadGen
======
Command line one-time pad generator. Should work on any unix-like system. Please, note: it's just a wrapper of your /dev/random. Probably, it's better not to use it in serious circumstances. Or try to feed your /dev/random from some hardware RNG.

Requirements
------------

Working `/dev/random`. Enough rigths to open it.

Usage
-----

padgen -p (number of pages) -l (lines per page) -c (number of columns)

Result
------
Something like this (`padgen -p 2 -l 6 -c 5` ):

    -----------------------------
    24797 29389 59161 43029 08815
    23613 48185 91066 18097 52367
    03931 86946 73144 10490 52740
    36581 05242 53058 29845 30973
    26195 01122 72861 97921 49471
    07973 96561 56750 54757 00523
    -----------------------------
    79848 49256 20859 99340 52267
    09125 29099 96714 89487 01684
    29220 70748 66355 77469 06648
    22096 04959 17284 80666 77548
    72106 03793 47042 24185 22996
    97342 89566 54350 25117 61066
    -----------------------------
