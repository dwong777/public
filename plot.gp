#! /usr/bin/gnuplot

# general plot parameters
set terminal png
set datafile separator ","

set title "Performance vs iteration with one thread"
set xlabel "Iterations"
set logscale x
set ylabel "ns/transition"
set logscale y
set output 'results1.png'
set key left top
plot \
	   "< grep -e 'Null,1,[0-9]*,6,5,[0-9.]*' results1.csv" using ($3):($6) \
	title 'Null' with linespoints lc rgb 'black', \
     "< grep -e 'Synchronized,1,[0-9]*,6,5,[0-9.]*' results1.csv" using ($3):($6) \
	title 'Synchronized' with linespoints lc rgb 'blue', \
     "< grep -e 'Unsynchronized,1,[0-9]*,6,5,[0-9.]*' results1.csv" using ($3):($6) \
	title 'Unsynchronized' with linespoints lc rgb 'red', \
     "< grep -e 'GetNSet,1,[0-9]*,6,5,[0-9.]*' results1.csv" using ($3):($6) \
	title 'GetNSet' with linespoints lc rgb 'orange', \
     "< grep -e 'BetterSafe,1,[0-9]*,6,5,[0-9.]*' results1.csv" using ($3):($6) \
	title 'BetterSafe' with linespoints lc rgb 'green', \

set title "Performance vs threads"
set xlabel "Threads"
set logscale x
set ylabel "ns/transition"
set logscale y
set output 'results2.png'
set key left top
plot \
	   "< grep -e 'Null,[0-9]*,1000000,6,5,[0-9.]*' results2.csv" using ($2):($6) \
	title 'Null' with linespoints lc rgb 'black', \
		   "< grep -e 'Synchronized,[0-9]*,1000000,6,5,[0-9.]*' results2.csv" using ($2):($6) \
	title 'Synchronized' with linespoints lc rgb 'blue', \
		   "< grep -e 'BetterSafe,[0-9]*,1000000,6,5,[0-9.]*' results2.csv" using ($2):($6) \
	title 'BetterSafe' with linespoints lc rgb 'green', \

set title "Performance vs array size"
set xlabel "Array Size"
set ylabel "ns/transition"
# set logscale y
set output 'results3.png'
set key left top
plot \
	   "< grep -e 'Null,6,1000000,6,[0-9]*,[0-9.]*' results3.csv" using ($5):($6) \
	title 'Null' with linespoints lc rgb 'black', \
		   "< grep -e 'Synchronized,6,1000000,6,[0-9]*,[0-9.]*' results3.csv" using ($5):($6) \
	title 'Synchronized' with linespoints lc rgb 'blue', \
		   "< grep -e 'BetterSafe,6,1000000,6,[0-9]*,[0-9.]*' results3.csv" using ($5):($6) \
	title 'BetterSafe' with linespoints lc rgb 'green', \
