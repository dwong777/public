#!/bin/bash

#Results format
#OPTION,THREADS,ITERATIONS,MAX_VAL,NUM_ELEMENTS,TIME

# Run with 1 thread and multiple iterations values
test1() {
	local num_runs=10

	local options=("Synchronized" "Unsynchronized" "GetNSet" "BetterSafe" "BetterSafeAlt" "Null")
	local threads=1
	local iterations=(100 10000 1000000 100000000)
	local max_val=6
	local test_arr=(5 6 3 0 3)

	for j in "${options[@]}" 
	do
		for k in "${iterations[@]}" 
		do
			acc=0
			for ((i=0;i<$num_runs;i++))
			do
				acc=$(echo $acc+$(java UnsafeMemory $j $threads $k $max_val ${test_arr[@]} | grep -o '[0-9.]*') | bc -l)
			done
			avg=$(echo $acc/$num_runs | bc -l)
			$(echo $j,$threads,$k,$max_val,${#test_arr[@]},$avg >> results1.csv)
		done
		echo "Test 1 completed for $j"
	done
}

# Test different thread values
test2() {
	local num_runs=10

	local options=("Synchronized" "BetterSafe" "BetterSafeAlt" "Null")
	local threads=(1 2 4 8 12 16 32) 
	local iterations=1000000
	local max_val=6
	local test_arr=(5 6 3 0 3)

	for j in "${options[@]}" 
	do
		for k in "${threads[@]}" 
		do
			acc=0
			for ((i=0;i<$num_runs;i++))
			do
				acc=$(echo $acc+$(java UnsafeMemory $j $k $iterations $max_val ${test_arr[@]} | grep -o '[0-9.]*') | bc -l)
			done
			avg=$(echo $acc/$num_runs | bc -l)
			$(echo $j,$k,$iterations,$max_val,${#test_arr[@]},$avg >> results2.csv)
		done
			echo "Test 2 completed for $j"
	done
}

# Test different array sizes
test3() {
	local num_runs=10

	local options=("Synchronized" "BetterSafe" "BetterSafeAlt" "Null")
	local threads=6
	local iterations=1000000
	local max_val=6
	local arr_0="5 6 3 0 3"
	local arr_1="5 6 3 0 3 2 3 2 4 3"
	local arr_2="5 6 3 0 3 2 3 2 4 3 2 5 0 6"
	local arr_3="5 6 3 0 3 2 3 2 4 3 2 5 0 6 1 1 2 3"
	local arr_4="5 6 3 0 3 2 3 2 4 3 2 5 0 6 1 1 2 3 6 3 2 5 3 1 5 6"
	local arrays=()
	arrays=("$arr_0" "$arr_1" "$arr_2" "$arr_3" "$arr_4")

	for j in "${options[@]}" 
	do
		for k in "${arrays[@]}" 
		do
			acc=0
			for ((i=0;i<$num_runs;i++))
			do
				acc=$(echo $acc+$(java UnsafeMemory $j $threads $iterations $max_val $k | grep -o '[0-9.]*') | bc -l)
			done
			avg=$(echo $acc/$num_runs | bc -l)
			len=$(((${#k}+1)/2))
			$(echo $j,$threads,$iterations,$max_val,$len,$avg >> results3.csv)
		done
		echo "Test 3 completed for $j"
	done
}

# Clear old data
rm results[0-9].csv

test1

test2

test3

echo ""